import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/model/categories_model.dart';
import 'package:smart_coupons/storage/categories_storage_service.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final List<Categories> _categories = [];

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryAddEvent>(_addCategory);
    on<CategoryDeleteEvent>(_deleteCategory);
    on<CategoryEditEvent>(_editCategory);
    on<CategoryLoadEvent>(_loadCategories);
  }

  Future<void> _loadCategories(
      CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    try {
      final savedCategories = await StorageService.loadCategories();
      _categories.clear();
      _categories.addAll(savedCategories);
      emit(CategoryLoaded(List.from(_categories)));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  Future<void> _addCategory(
    CategoryAddEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final newCategory = Categories.create(event.title);
      _categories.add(newCategory);
      await StorageService.saveCategories(_categories);
      emit(CategoryLoaded(List.from(_categories)));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  Future<void> _deleteCategory(
    CategoryDeleteEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      _categories.removeWhere((category) => category.id == event.id);
      await StorageService.saveCategories(_categories);
      emit(CategoryLoaded(List.from(_categories)));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  Future<void> _editCategory(
    CategoryEditEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final index =
          _categories.indexWhere((category) => category.id == event.id);
      if (index == -1) return;

      _categories[index] = _categories[index].copyWith(title: event.newTitle);
      await StorageService.saveCategories(_categories);
      emit(CategoryLoaded(List.from(_categories)));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
}
