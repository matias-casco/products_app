import 'package:flutter/material.dart';

class ProductTagChips extends StatelessWidget {
  const ProductTagChips({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        tags.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(
              label: Text(tags[index]),
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .tertiaryContainer,
            ),
          );
        },
      ),
    );
  }
}
