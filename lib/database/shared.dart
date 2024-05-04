import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:enthrirhc/libs/misc.dart';
import '../utils/types.dart';

export 'unsupported.dart' if (dart.library.ffi) 'native.dart' if (dart.library.html) 'web.dart';

part 'shared.g.dart';

Root decodeRootRow(RootItem row) {
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

StandardAffix decodeAffixRow(AffixItem row) {
  final degreeList = jsonDecode(row.degrees) as List<dynamic>;
  final degrees = degreeList.map((degree) {
    if (degree is String) {
      return MergedDegree(degree);
    } else if (degree is List) {
      return SeparatedDegree(degree[0], degree[1]);
    } else {
      assert(degree == null);
      return null;
    }
  }).toList();

  return StandardAffix(
    name: row.name,
    description: row.description,
    gradientType: GradientType.from(row.gradientType).unwrap(),
    cs: row.cs,
    associatedRoot: row.associatedRoot,
    degrees: degrees,
    notes: row.notes,
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

sealed class SearchResultItem {
  const SearchResultItem();
}

class RootSRI extends SearchResultItem {
  final Root root;
  const RootSRI(this.root);
}

class AffixSRI extends SearchResultItem {
  final StandardAffix affix;
  const AffixSRI(this.affix);
}

@DriftDatabase(tables: [RootTable, AffixTable])
class Database extends _$Database {
  Database(super.e);

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
            gradientType: affix.gradientType.toString(),
            cs: affix.cs,
            associatedRoot: affix.associatedRoot,
            degrees: jsonEncode(affix.degrees),
            notes: Value(affix.notes),
          ),
        ),
      );
    });
  }

  Future<List<SearchResultItem>> search(String keywords) async {
    final List<SearchResultItem> results = [];
    final wholeWordRegex = "\\b${escapeRegExp(keywords)}\\b";

    final statement1 = select(rootTable)..where((tbl) => tbl.root.equals(keywords.toUpperCase()));
    final item1 = await statement1.getSingleOrNull();
    if (item1 != null) {
      results.add(RootSRI(decodeRootRow(item1)));
    }

    final statement2 = select(affixTable)..where((tbl) => tbl.cs.equals(keywords.toLowerCase()));
    final item2 = await statement2.getSingleOrNull();
    if (item2 != null) {
      results.add(AffixSRI(decodeAffixRow(item2)));
    }

    final statement3 = select(affixTable)..where((tbl) => tbl.name.equals(keywords.toUpperCase()));
    final item3 = await statement3.getSingleOrNull();
    if (item3 != null) {
      results.add(AffixSRI(decodeAffixRow(item3)));
    }

    // Get the roots whose `root` field contains keyword.
    final statement4 = select(rootTable)..where((tbl) => tbl.root.contains(keywords));
    final rows4 = await statement4.get();
    results.addAll(
      rows4.map((item) => RootSRI(decodeRootRow(item))).toList(),
    );

    // Get the affixes whose `cs` field contains keyword.
    final statement5 = select(affixTable)..where((tbl) => tbl.cs.contains(keywords));
    final rows5 = await statement5.get();
    results.addAll(
      rows5.map((item) => AffixSRI(decodeAffixRow(item))).toList(),
    );

    // Get the roots whose `refers` field contains keyword.
    final statement6 = select(rootTable)..where((tbl) => tbl.refers.regexp(wholeWordRegex));
    final rows6 = await statement6.get();
    results.addAll(
      rows6.map((item) => RootSRI(decodeRootRow(item))).toList(),
    );

    // Get the affixes whose `description` field contains keyword.
    final statement7 = select(affixTable)..where((tbl) => tbl.description.regexp(wholeWordRegex));
    final rows7 = await statement7.get();
    results.addAll(
      rows7.map((item) => AffixSRI(decodeAffixRow(item))).toList(),
    );

    // Get the roots whose `stems` field contains keyword.
    final statement8 = select(rootTable)..where((tbl) => tbl.stems.regexp(wholeWordRegex));
    final rows8 = await statement8.get();
    results.addAll(
      rows8.map((item) => RootSRI(decodeRootRow(item))).toList(),
    );

    // Get the affixes whose `degrees` field contains keyword.
    final statement9 = select(affixTable)..where((tbl) => tbl.degrees.regexp(wholeWordRegex));
    final rows9 = await statement9.get();
    results.addAll(
      rows9.map((item) => AffixSRI(decodeAffixRow(item))).toList(),
    );

    final List<SearchResultItem> deduplicatedResults = [];
    for (var i = 0; i < results.length; i++) {
      final thisItem = results[i];
      final hasDuplicatedElement = switch (thisItem) {
        RootSRI(root: final thisRoot) => deduplicatedResults.any((item) => switch (item) {
              RootSRI(root: final root) => root.root == thisRoot.root,
              AffixSRI() => false,
            }),
        AffixSRI(affix: final thisAffix) => deduplicatedResults.any((item) => switch (item) {
              RootSRI() => false,
              AffixSRI(affix: final affix) => affix.cs == thisAffix.cs,
            }),
      };
      if (!hasDuplicatedElement) {
        deduplicatedResults.add(thisItem);
      }
      if (deduplicatedResults.length == 100) {
        return deduplicatedResults;
      }
    }

    return deduplicatedResults;
  }

  Future<Root?> exactSearch(String root) async {
    // TODO: Currently we have duplicate roots, so we cannot use `getSingleOrNull` method, but only
    // limit the number of returned results to be one, until we eliminate all the duplicate roots.
    final statement = select(rootTable)
      ..where((tbl) => tbl.root.equals(root))
      ..limit(1);
    final rows = await statement.get();
    return rows.isNotEmpty ? decodeRootRow(rows[0]) : null;
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
