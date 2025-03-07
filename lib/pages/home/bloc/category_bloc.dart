import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/model/categories_model.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final List<Categories> _categories = [];

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryAddEvent>(_addCategory);
  }

  Future<void> _addCategory(
    CategoryAddEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final newCategory = Categories(title: event.title);
      _categories.add(newCategory);
      emit(CategoryListUpdate(List.from(_categories)));
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }
}
