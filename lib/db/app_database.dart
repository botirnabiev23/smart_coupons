// lib/db/tables/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_coupons/db/tables/categories_table.dart';

import 'dao/category_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories], daos: [CategoryDao])
class AppDatabase extends _$AppDatabase {
  // Private constructor for singleton
  AppDatabase._internal() : super(_openConnection());

  // Singleton instance
  static final AppDatabase _instance = AppDatabase._internal();

  // Factory constructor to return the same instance
  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  // Override close to avoid closing the singleton instance accidentally
  @override
  Future<void> close() async {
    // Prevent closing the database externally
    return;
  }
}

// Connection setup
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_2.db'));
    return NativeDatabase(file);
  });
}