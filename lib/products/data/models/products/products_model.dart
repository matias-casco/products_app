import 'package:products_app/products/data/models/products/product_model.dart';
import 'package:products_app/products/domain/entities/products/products.dart';


class ProductsModel {
    final List<ProductModel> products;
    final int total;
    final int skip;
    final int limit;

    ProductsModel({
        required this.products,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory ProductsModel.fromJson(Map<String, dynamic> json) {
      return ProductsModel(
        products: List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );
    }

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };

    Products toEntity() => Products(
      productsDetails: products.map((e) => e.toEntity()).toList(),
      total: total,
      skip: skip,
      limit: limit,
      
    );


}