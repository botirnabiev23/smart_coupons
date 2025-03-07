part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryAddEvent extends CategoryEvent {
  final String title;
  const CategoryAddEvent(this.title);

  @override
  List<Object?> get props => [title];
}

