import 'dart:convert';

import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../common/types.dart';

part 'lexicon.g.dart';

@DataClassName('RootRow')
class Lexicon extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get root => text()();
  TextColumn get refers => text().nullable()();
  TextColumn get stem1 => text().nullable()();
  TextColumn get stem2 => text().nullable()();
  TextColumn get stem3 => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get see => text().nullable()();
}

@DriftDatabase(tables: [Lexicon])
class Database extends _$Database {
  Database() : super(_openConnection());

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
            stem1: Value((root.stems?[0] is String)
                ? (root.stems?[0])
                : json.encode(root.stems?[0])),
            stem2: Value((root.stems?[1] is String)
                ? (root.stems?[1])
                : json.encode(root.stems?[1])),
            stem3: Value((root.stems?[2] is String)
                ? (root.stems?[2])
                : json.encode(root.stems?[2])),
            notes: Value(root.notes),
            see: Value(root.see),
          ),
        ),
      );
    });
  }

  Future<List<RootRow>> search() async {
    return select(lexicon).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
