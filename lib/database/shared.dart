import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:enthrirhc/libs/misc.dart';
import '../utils/types.dart';

export 'unsupported.dart' if (dart.library.ffi) 'native.dart' if (dart.library.html) 'web.dart';

part 'shared.g.dart';

Root rowToRoot(RootItem row) {
  final List<Stem>? stems;
  if (row.stems != null) {
    final List<dynamic> decodeStems = jsonDecode(row.stems!);
    stems = decodeStems.map((stem) => Stem.from(stem)).toList();
  } else {
    stems = null;
  }
  return Root(
    root: row.root,
    refers: row.refers,
    stems: stems,
    notes: row.notes,
    seeAlso: row.see,
  );
}

@DataClassName('RootItem')
class RootTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get root => text()();
  TextColumn get refers => text().nullable()();
  TextColumn get stems => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get see => text().nullable()();
}

@DataClassName('AffixItem')
class AffixTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get gradientType => text()();
  TextColumn get cs => text()();
  BoolColumn get associatedRoot => boolean()();
  TextColumn get degrees => text()();
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(tables: [RootTable, AffixTable])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<void> insert(Lexicon lexicon) async {
    await batch((batch) {
      batch.insertAll(
        rootTable,
        lexicon.roots.map(
          (root) => RootTableCompanion.insert(
            root: root.root,
            refers: Value(root.refers),
            stems: Value(root.stems != null ? jsonEncode(root.stems) : null),
            notes: Value(root.notes),
            see: Value(root.seeAlso),
          ),
        ),
      );
      batch.insertAll(
        affixTable,
        lexicon.standardAffixes.map(
          (affix) => AffixTableCompanion.insert(
            name: affix.name,
            description: affix.description,
            gradientType: affix.gradientType.name,
            cs: affix.cs,
            associatedRoot: affix.associatedRoot,
            degrees: jsonEncode(affix.degrees),
          ),
        ),
      );
    });
  }

  Future<List<Root>> search(String keywords) async {
    // Get the roots whose `root` field matches keyword.
    final statement1 = select(rootTable)..where((tbl) => tbl.root.contains(keywords.toUpperCase()));
    final rows1 = await statement1.get();
    final list1 = rows1.map((row) => rowToRoot(row)).toList();
    // Move the exactly matched root to the head of the search result.
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].root == keywords.toUpperCase()) {
        final temp = list1[0];
        list1[0] = list1[i];
        list1[i] = temp;
        break;
      }
    }

    // Get the roots whose `refers` field matches keyword.
    final statement2 = select(rootTable)..where((tbl) => tbl.refers.contains(keywords));
    final rows2 = await statement2.get();
    final list2 = rows2.map((row) => rowToRoot(row)).toList();
    final escapedKeywords = escapeRegExp(keywords.toLowerCase());
    final keywordsRegExp = RegExp("(^|\\W)$escapedKeywords(\\W|\$)", caseSensitive: false);
    int index = 0;
    for (int i = 0; i < list2.length; i++) {
      final refers = list2[i].refers;
      if (refers == null) {
        continue;
      }
      if (keywordsRegExp.hasMatch(refers)) {
        final temp = list2[index];
        list2[index] = list2[i];
        list2[i] = temp;
        index += 1;
      }
    }

    final mergedList = list1..addAll(list2);
    final List<Root> list = [];
    for (final thisRoot in mergedList) {
      if (!list.any((root) => root.root == thisRoot.root)) {
        list.add(thisRoot);
      }
      if (list.length == 100) {
        break;
      }
    }

    return list;
  }

  Future<Root?> exactSearch(String root) async {
    // TODO: Currently we have duplicate roots, so we cannot use `getSingleOrNull` method, but only
    // limit the number of returned results to be one, until we eliminate all the duplicate roots.
    final statement = select(rootTable)
      ..where((tbl) => tbl.root.equals(root))
      ..limit(1);
    final rows = await statement.get();
    return rows.isNotEmpty ? rowToRoot(rows[0]) : null;
  }

  Future<int> rootCount() async {
    final countExpr = rootTable.id.count();
    final query = selectOnly(rootTable)..addColumns([countExpr]);
    final result = await query.map((row) => row.read(countExpr)).getSingle();
    return result!;
  }

  Future<int> affixCount() async {
    final countExpr = affixTable.id.count();
    final query = selectOnly(affixTable)..addColumns([countExpr]);
    final result = await query.map((row) => row.read(countExpr)).getSingle();
    return result!;
  }

  Future<void> clearLexicon() async {
    await delete(affixTable).go();
    await delete(rootTable).go();
  }
}
