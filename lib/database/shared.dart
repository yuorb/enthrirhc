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

  Future<List<RootRow>> search(String keywords) async {
    return (select(lexicon)
          ..where((tbl) {
            return tbl.root.contains(keywords);
          }))
        .get();
  }
}
