import 'package:uuid/uuid.dart';

class CouponCategory {
  final String id;
  final String title;

  CouponCategory({required this.id, required this.title});

  CouponCategory copyWith({String? title}) {
    return CouponCategory(
      id: id,
      title: title ?? this.title,
    );
  }

  factory CouponCategory.create(String title) {
    return CouponCategory(id: Uuid().v4(), title: title);
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title};

  factory CouponCategory.fromJson(Map<String, dynamic> json) {
    return CouponCategory(id: json["id"], title: json["title"]);
  }
}
