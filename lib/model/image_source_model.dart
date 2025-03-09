import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_source_model.freezed.dart';

part 'image_source_model.g.dart';

@Freezed(fromJson: true, toJson: true)
sealed class ImageSourceModel with _$ImageSourceModel {
  const factory ImageSourceModel.local(String path) = LocalImageSourceModel;

  const factory ImageSourceModel.network(String url) = NetworkImageSourceModel;

  factory ImageSourceModel.fromJson(Map<String, dynamic> json) =>
      _$ImageSourceModelFromJson(json);
}
