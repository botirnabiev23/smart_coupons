part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, error }

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(CategoryStatus.initial) CategoryStatus status,
    @Default([]) List<CouponCategory> categories,
  }) = _CategoryState;
}
