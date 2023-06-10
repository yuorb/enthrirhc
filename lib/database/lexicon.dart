import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'lexicon.g.dart';

@DataClassName('Root')
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
