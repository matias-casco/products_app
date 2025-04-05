import 'package:flutter/material.dart';

import 'package:products_app/products/domain/entities/products/product_details.dart';
import 'package:products_app/products/presentation/views/product_details_view.dart';

class ProductDetailsExtra {
  const ProductDetailsExtra({required this.details});

  final ProductDetails details;
}

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.extra});

  static const name = 'ProductDetails';
  static const path = '/products_details';

  final ProductDetailsExtra extra;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      body: ProductDetailsView(product: extra.details),
    );
  }
}
