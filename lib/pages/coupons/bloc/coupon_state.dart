part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CouponsInitial extends CouponState {}

class CouponsLoaded extends CouponState {
  final List<Coupon> coupons;
  CouponsLoaded(this.coupons);

  @override
  List<Object?> get props => [coupons];
}

class CouponsError extends CouponState {
  final String message;
  CouponsError(this.message);

  @override
  List<Object?> get props => [message];
}
