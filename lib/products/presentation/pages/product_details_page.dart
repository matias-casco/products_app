import 'package:flutter/material.dart';

import 'package:products_app/products/domain/entities/product_details.dart';

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
      appBar: AppBar(title: const Text('Product Details')),
      body: Column(
        children: [
          Image.network(
            extra.details.thumbnail,
            width: double.infinity,
            height: 180,
            fit: BoxFit.scaleDown,
          ),
          Text('Product Name: ${extra.details.title}'),
          Text('Product Price: ${extra.details.price}'),
          Text('Product Category: ${extra.details.category}'),
          Text('Product Rating: ${extra.details.rating}'),
          Text('Product Description: ${extra.details.description}'),
          
        ],
      ),
    );
  }
}
