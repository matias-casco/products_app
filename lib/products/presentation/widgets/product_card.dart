import 'package:flutter/material.dart';

import 'package:products_app/products/domain/entities/products/product_details.dart';
import 'package:products_app/products/presentation/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductDetails product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  product.thumbnail,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(product.title),
                  subtitle: Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 14,
                )
              ],
            ),
            Positioned(
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: PriceContainer(
                text: '\$${product.price}',
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
