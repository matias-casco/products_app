import 'package:flutter/material.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer(
      {super.key, required this.text, this.color, this.borderRadius});

  final String text;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
