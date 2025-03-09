class Coupon {
  final String id;
  final String name;
  final String? image;
  final DateTime date;

  Coupon({
    required this.id,
    required this.name,
    this.image,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'date': date.toIso8601String(),
    };
  }

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      date: DateTime.parse(json['date']),
    );
  }
}
