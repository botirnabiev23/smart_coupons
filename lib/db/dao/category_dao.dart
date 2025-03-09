// lib/db/dao/category_dao.dart
import 'package:drift/drift.dart';
import 'package:smart_coupons/db/app_database.dart';
import 'package:smart_coupons/db/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  Future<void> addCategory(String title) async {
    final String id = Uuid().v4();
    await into(categories).insert(CategoriesCompanion(
      id: Value(id),
      title: Value(title),
    ));
  }

  Future<void> deleteCategory(String id) async {
    await (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> editCategory(String id, String title) async {
    await (update(categories)..where((tbl) => tbl.id.equals(id)))
        .write(CategoriesCompanion(title: Value(title)));
  }
}
