import 'package:flutter/material.dart';
import 'package:products_app/products/domain/entities/review.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
    required this.review,
    this.color,
  });

  final Review review;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.reviewerName,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                'Rated: ${review.rating} stars',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            review.comment,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '',
              ),
              Text(
                review.date.toLocal().toString(),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
