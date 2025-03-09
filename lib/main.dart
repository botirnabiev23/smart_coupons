import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/home/home_page.dart';

import 'bloc_observer.dart';
import 'db/app_database.dart';
import 'db/dao/category_dao.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  final AppDatabase appDatabase = AppDatabase();
  final CategoryDao categoryDao = CategoryDao(appDatabase);

  runApp(
    MyApp(
      categoryDao: categoryDao,
    ),
  );
}

class MyApp extends StatelessWidget {
  final CategoryDao categoryDao;

  const MyApp({
    super.key,
    required this.categoryDao,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: categoryDao),
      ],
      child: MaterialApp(
        title: 'Smart Coupons',
        home: const HomePage(),
      ),
    );
  }
}
