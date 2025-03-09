import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_coupons/db/app_database.dart';
import 'package:smart_coupons/db/dao/category_dao.dart';

part 'category_event.dart';

part 'category_state.dart';

part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryDao categoryDao;

  CategoryBloc({
    required this.categoryDao,
  }) : super(const CategoryState()) {
    on<CategoryStartListeningEvent>(_startListening);
    on<CategoryAddEvent>(_addCategory);
    on<CategoryDeleteEvent>(_deleteCategory);
    on<CategoryEditEvent>(_editCategory);
  }

  Future<void> _startListening(
    CategoryStartListeningEvent event,
    Emitter<CategoryState> emit,
  ) async {
    await emit.forEach<List<Category>>(
      categoryDao.watchAllCategories(),
      onData: (categories) => state.copyWith(
        status: CategoryStatus.loaded,
        categories: categories,
      ),
      onError: (error, stackTrace) {
        return state.copyWith(status: CategoryStatus.error);
      },
    );
  }

  Future<void> _addCategory(
    CategoryAddEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryDao.addCategory(event.title);
    } catch (e) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  Future<void> _deleteCategory(
    CategoryDeleteEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryDao.deleteCategory(event.id);
    } catch (e) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  Future<void> _editCategory(
    CategoryEditEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryDao.editCategory(
        event.id,
        event.updatedTitle,
      );
    } catch (e) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }
}
