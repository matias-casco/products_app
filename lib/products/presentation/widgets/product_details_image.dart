
import 'package:flutter/material.dart';

class ProductDetailsImage extends StatelessWidget {
  const ProductDetailsImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.scaleDown,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerLow,
              child:
                  const Text('Image not available')),
        );
      },
      loadingBuilder:
          (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

