import 'package:products_app/products/domain/entities/products/dimensions.dart';

class DimensionsModel {
    final double width;
    final double height;
    final double depth;

    DimensionsModel({
        required this.width,
        required this.height,
        required this.depth,
    });

    factory DimensionsModel.fromJson(Map<String, dynamic> json) => DimensionsModel(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
    };

    Dimensions toEntity() => Dimensions(
      width: width,
      height: height,
      depth: depth,
    );
}