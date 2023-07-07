import 'dart:convert';

import 'package:drift/drift.dart';
import '../common/types.dart';

export 'unsupported.dart' if (dart.library.ffi) 'native.dart' if (dart.library.html) 'web.dart';

part 'shared.g.dart';

@DataClassName('RootRow')
class Lexicon extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get root => text()();
  TextColumn get refers => text().nullable()();
  TextColumn get stems => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get see => text().nullable()();
}

@DriftDatabase(tables: [Lexicon])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<void> init(List<Root> roots) async {
    await delete(lexicon).go();
    await batch((batch) {
      batch.insertAll(
        lexicon,
        roots.map(
          (root) => LexiconCompanion.insert(
            root: root.root,
            refers: Value(root.refers),
            stems: Value(jsonEncode(root.stems)),
            notes: Value(root.notes),
            see: Value(root.see),
          ),
        ),
      );
    });
  }

  Future<List<Root>> search(String keywords) async {
    final rows = await (select(lexicon)..where((tbl) => tbl.root.contains(keywords))).get();
    return rows.map(
      (row) {
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
          see: row.see,
        );
      },
    ).toList();
  }

  Future<int> rootCount() async {
    final countExpr = lexicon.id.count();
    final query = selectOnly(lexicon)..addColumns([countExpr]);
    final result = await query.map((row) => row.read(countExpr)).getSingle();
    return result!;
  }
}
