part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCoupons extends CouponEvent {
  final String categoryId;

  LoadCoupons({
    required this.categoryId,
  });

  @override
  List<Object?> get props => [categoryId];
}

class AddCoupon extends CouponEvent {
  final String categoryId;
  final Coupon coupon;

  AddCoupon({
    required this.categoryId,
    required this.coupon,
  });

  @override
  List<Object?> get props => [
        categoryId,
        coupon,
      ];
}

class DeleteCoupon extends CouponEvent {
  final String categoryId;
  final String couponId;

  DeleteCoupon({
    required this.categoryId,
    required this.couponId,
  });

  @override
  List<Object?> get props => [
        categoryId,
        couponId,
      ];
}
