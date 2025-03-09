part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Categories> categories;
  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryErrorState extends CategoryState {
  final String error;
  const CategoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
