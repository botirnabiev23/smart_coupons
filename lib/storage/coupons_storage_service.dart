import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'dart:convert';

class CouponStorageService {
  static const String _couponsKey = "coupons_list";

  static Future<void> saveCoupons(List<Coupon> coupons) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(coupons.map((c) => c.toJson()).toList());
    await prefs.setString(_couponsKey, jsonString);
  }

  static Future<List<Coupon>> loadCoupons() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_couponsKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Coupon.fromJson(json)).toList();
  }

  static Future<void> addCoupon(Coupon coupon) async {
    List<Coupon> coupons = await loadCoupons();
    coupons.add(coupon);
    await saveCoupons(coupons);
  }

  static Future<void> deleteCoupon(String id) async {
    List<Coupon> coupons = await loadCoupons();
    coupons.removeWhere((coupon) => coupon.id == id);
    await saveCoupons(coupons);
  }
}
