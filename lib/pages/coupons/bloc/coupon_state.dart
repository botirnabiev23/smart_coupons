part of 'coupon_bloc.dart';

enum CouponStatus { initial, loading, loaded, error }

@freezed
class CouponState with _$CouponState {
  const factory CouponState({
    @Default(CouponStatus.initial) CouponStatus status,
    @Default([]) List<Coupon> coupons,
    @Default('') String errorMessage,
  }) = _CouponState;
}
