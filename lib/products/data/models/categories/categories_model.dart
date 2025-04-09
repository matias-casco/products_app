import 'package:products_app/products/data/models/categories/category_model.dart';
import 'package:products_app/products/domain/entities/categories/categories.dart';

class CategoriesModel {
  List<CategoryModel> categories;

  CategoriesModel({
    required this.categories,
  });

  factory CategoriesModel.fromJson(List<dynamic> json) =>
      CategoriesModel(
        categories: List<CategoryModel>.from(
            json.map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };

  Categories toEntity() => Categories(
        categories: categories.map((e) => e.toEntity()).toList(),
      );
}
