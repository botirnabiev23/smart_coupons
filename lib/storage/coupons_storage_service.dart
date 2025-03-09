import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'dart:convert';

class CouponStorageService {
  static const String _couponsKey = "coupons_list";

  static Future<void> saveCoupons({
    required String categoryId,
    required List<Coupon> coupons,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(coupons.map((c) => c.toJson()).toList());
    await prefs.setString(categoryId, jsonString);
  }

  static Future<List<Coupon>> loadCoupons({
    required String categoryId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(categoryId);

    if (jsonString == null) {
      print('No coupons found for category: $categoryId');
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);
    final coupons = jsonList.map((json) => Coupon.fromJson(json)).toList();

    return coupons;
  }

  static Future<void> addCoupon({
    required String categoryId,
    required Coupon coupon,
  }) async {
    List<Coupon> coupons = await loadCoupons(categoryId: categoryId);
    coupons.add(coupon);
    await saveCoupons(
      categoryId: categoryId,
      coupons: coupons,
    );
  }

  static Future<void> updateCoupon({
    required String categoryId,
    required Coupon updatedCoupon,
  }) async {
    List<Coupon> coupons = await loadCoupons(categoryId: categoryId);

    final index = coupons.indexWhere((coupon) => coupon.id == updatedCoupon.id);

    if (index == -1) {
      return;
    }
    coupons[index] = updatedCoupon;

    await saveCoupons(
      categoryId: categoryId,
      coupons: coupons,
    );
  }

  static Future<void> deleteCoupon({
    required String categoryId,
    required String couponId,
  }) async {
    List<Coupon> coupons = await loadCoupons(
      categoryId: categoryId,
    );
    coupons.removeWhere((coupon) => coupon.id == couponId);
    await saveCoupons(
      categoryId: categoryId,
      coupons: coupons,
    );
  }
}
