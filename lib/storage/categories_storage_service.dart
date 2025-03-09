import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_coupons/model/categories_model.dart';

class StorageService {
  static const String _categoriesKey = "categories_list";

  static Future<void> saveCategories(List<CouponCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(categories.map((c) => c.toJson()).toList());

    await prefs.setString(_categoriesKey, jsonString);
  }

  static Future<List<CouponCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_categoriesKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => CouponCategory.fromJson(json)).toList();
  }

  static Future<void> deleteCategory(String id) async {
    // final prefs = await SharedPreferences.getInstance();
    List<CouponCategory> categories = await loadCategories();
    categories.removeWhere((category) => category.id == id);
    await saveCategories(categories);
  }
}
