import 'package:products_app/products/data/models/dimensions_model.dart';
import 'package:products_app/products/data/models/meta_model.dart';
import 'package:products_app/products/data/models/review_model.dart';
import 'package:products_app/products/domain/entities/product_details.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final int weight;
  final DimensionsModel dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewModel> reviews;
  final String? returnPolicy;
  final int minimumOrderQuantity;
  final MetaModel meta;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        brand: json["brand"],
        sku: json["sku"],
        weight: json["weight"],
        dimensions: DimensionsModel.fromJson(json["dimensions"]),
        warrantyInformation: json["warrantyInformation"],
        shippingInformation: json["shippingInformation"],
        availabilityStatus: json["availabilityStatus"],
        reviews: List<ReviewModel>.from(
            json["reviews"].map((x) => ReviewModel.fromJson(x))),
        returnPolicy: json["returnPolicy"]!,
        minimumOrderQuantity: json["minimumOrderQuantity"],
        meta: MetaModel.fromJson(json["meta"]),
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformation,
        "availabilityStatus": availabilityStatus,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "returnPolicy": returnPolicy,
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
      };

  ProductDetails toEntity() => ProductDetails(
        id: id,
        title: title,
        description: description,
        category: category,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        tags: tags,
        brand: brand,
        sku: sku,
        weight: weight,
        dimensions: dimensions.toEntity(),
        warrantyInformation: warrantyInformation,
        shippingInformation: shippingInformation,
        availabilityStatus: availabilityStatus,
        reviews: reviews.map((e) => e.toEntity()).toList(),
        returnPolicy: returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity,
        meta: meta.toEntity(),
        images: images,
        thumbnail: thumbnail,
      );
}
