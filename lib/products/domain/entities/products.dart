import 'package:equatable/equatable.dart';
import 'package:products_app/products/domain/entities/product_details.dart';

class Products extends Equatable {
  final List<ProductDetails> productsDetails;
  final int? total;
  final int? skip;
  final int? limit;

  const Products({
    required this.productsDetails,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        productsDetails,
        total,
        skip,
        limit,
      ];
}
