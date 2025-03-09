part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCoupons extends CouponEvent {}

class AddCoupon extends CouponEvent {
  final Coupon coupon;
  AddCoupon(this.coupon);

  @override
  List<Object?> get props => [coupon];
}

class DeleteCoupon extends CouponEvent {
  final String id;
  DeleteCoupon(this.id);

  @override
  List<Object?> get props => [id];
}
