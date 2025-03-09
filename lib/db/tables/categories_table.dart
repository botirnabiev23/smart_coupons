import 'package:drift/drift.dart';

class Categories extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  @override
  Set<Column> get primaryKey => {
        id,
      };
}
