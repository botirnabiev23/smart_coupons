import 'package:freezed_annotation/freezed_annotation.dart';
import 'image_source_model.dart';

part 'coupon_model.freezed.dart';

part 'coupon_model.g.dart';

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required String id,
    required String name,
    required ImageSourceModel imageSource,
    required DateTime date,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}
