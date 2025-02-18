import 'package:flutter/material.dart';
import 'package:products_app/products/domain/entities/product_details.dart';

class ProductDetailsExtra {
  const ProductDetailsExtra({required this.details});

  final ProductDetails details;
}

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, this.extra});

  static const name = 'ProductDetails';
  static const path = '/products_details';

  final ProductDetailsExtra? extra;

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
