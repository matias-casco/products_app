import 'package:flutter/material.dart';

import 'package:products_app/products/domain/entities/product_details.dart';
import 'package:products_app/products/presentation/widgets/widgets.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {

    const mainVerticalGap = SizedBox(height: 30);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          title: Text(product.title),
          flexibleSpace: _ProductFlexibleSpaceBar(product: product),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               mainVerticalGap,
                Text(product.title,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Text(product.description),
               mainVerticalGap,
                _SecondaryInfoRow(product: product),
               mainVerticalGap,
                //wrap the tags in a row
                ProductTagChips(tags: product.tags),
               mainVerticalGap,
                MoreInfoSection(
                  infoTexts: [
                    product.shippingInformation,
                    product.warrantyInformation,
                    product.dimensionsText,
                    product.returnPolicy ?? '',
                  ],
                ),
                mainVerticalGap,
                //add reviews
                _ReviewsSection(product: product),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

class _ProductFlexibleSpaceBar extends StatelessWidget {
  const _ProductFlexibleSpaceBar({
    required this.product,
  });

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      expandedTitleScale: 1.0,
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      background: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            children: List.generate(
              product.images.length,
              (index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: kToolbarHeight,
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 1],
                          colors: [
                            Theme.of(context).colorScheme.surface,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: ProductDetailsImage(
                        image: product.images[index],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${index + 1}/${product.images.length}',
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).padding.top + 40,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                product.category.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: PriceContainer(
              text: '\$ ${product.price}',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryInfoRow extends StatelessWidget {
  const _SecondaryInfoRow({
    required this.product,
  });

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.availabilityStatus,
                style: TextStyle(
                  color: product.availabilityStatus == 'In Stock'
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.error,
                )),
            Text('Min. order: ${product.minimumOrderQuantity}',
                style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        Text(
          'Code: ${product.sku}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({
    required this.product,
  });

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 12,
        ),
        for (var review in product.reviews) ReviewContainer(review: review),
      ],
    );
  }
}
