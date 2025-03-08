import 'package:uuid/uuid.dart';

class Categories {
  final String id;
  final String title;

  Categories({required this.id, required this.title});

  Categories copyWith({String? title}) {
    return Categories(
      id: id,
      title: title ?? this.title,
    );
  }

  factory Categories.create(String title) {
    return Categories(id: Uuid().v4(), title: title);
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title};

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(id: json["id"], title: json["title"]);
  }
}
