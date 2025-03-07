part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryListUpdate extends CategoryState {
  final List<Categories> categories;

  const CategoryListUpdate(this.categories);

  @override
  List<Object?> get props => [categories];
}

final class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoriesErrorState extends CategoryState {
  final String error;

  const CategoriesErrorState(this.error);

  @override
  List<Object?> get props => throw UnimplementedError();
}
