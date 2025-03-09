import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_coupons/model/categories_model.dart';
import 'package:smart_coupons/storage/categories_storage_service.dart';

part 'category_event.dart';

part 'category_state.dart';

part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<CategoryLoadEvent>(_loadCategories);
    on<CategoryAddEvent>(_addCategory);
    on<CategoryDeleteEvent>(_deleteCategory);
    on<CategoryEditEvent>(_editCategory);
  }

  Future<void> _loadCategories(
    CategoryLoadEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final List<CouponCategory> categories =
          await StorageService.loadCategories();

      emit(
        state.copyWith(
          status: CategoryStatus.loaded,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
      ));
    }
  }

  Future<void> _addCategory(
    CategoryAddEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final newCategory = CouponCategory.create(event.title);
      final newCategories = [
        ...state.categories,
        newCategory,
      ];
      await StorageService.saveCategories(newCategories);
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        categories: newCategories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
      ));
    }
  }

  Future<void> _deleteCategory(
    CategoryDeleteEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final newCategories = state.categories
          .where((category) => category.id != event.id)
          .toList();

      await StorageService.saveCategories(newCategories);
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        categories: newCategories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
      ));
    }
  }

  Future<void> _editCategory(
    CategoryEditEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final newCategories = state.categories.map((category) {
        if (category.id == event.id) {
          return category.copyWith(title: event.updatedTitle);
        }
        return category;
      }).toList();

      await StorageService.saveCategories(newCategories);
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        categories: newCategories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
      ));
    }
  }
}
