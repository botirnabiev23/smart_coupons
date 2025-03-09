part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryLoadEvent extends CategoryEvent {}

class CategoryAddEvent extends CategoryEvent {
  final String title;
  const CategoryAddEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class CategoryDeleteEvent extends CategoryEvent {
  final String id;
  const CategoryDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CategoryEditEvent extends CategoryEvent {
  final String id;
  final String newTitle;

  const CategoryEditEvent(this.id, this.newTitle);

  @override
  List<Object?> get props => [id, newTitle];
}

