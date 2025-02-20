import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:products_app/core/injector/injector.dart';
import 'package:products_app/products/presentation/notifiers/products_page_notifier.dart';
import 'package:products_app/products/presentation/pages/product_details_page.dart';
import 'package:products_app/products/presentation/widgets/product_card.dart';
import 'package:products_app/products/presentation/widgets/widgets.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final _productsNotifier = sl<ProductsPageNotifier>();

  @override
  void dispose() {
    _productsNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _productsNotifier.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return _productsNotifier.getProducts();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Special Offers',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            _ProductsBuilder(productsNotifier: _productsNotifier),
          ],
        ),
      ),
    );
  }
}

class _ProductsBuilder extends StatelessWidget {
  const _ProductsBuilder({
    required ProductsPageNotifier productsNotifier,
  }) : _productsNotifier = productsNotifier;

  final ProductsPageNotifier _productsNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _productsNotifier.productsState,
      builder: (context, state, child) {
        if (state.status == ProductsPageStatus.error) {
          return ErrorMessageContainer(
            errorMessage: state.errorMessage,
            onRetryPressed: () {
              _productsNotifier.getProducts();
            },
          );
        }

        if (state.status == ProductsPageStatus.loading ||
            state.products == null) {
          return const Column(
            children: [
               SizedBox(
                height: 200,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }

        return Column(
          children: List.generate(
            state.products!.productsDetails.length,
            (index) {
              final product = state.products!.productsDetails[index];
              return ProductCard(
                  product: product,
                  onTap: () {
                    context.push(
                      ProductDetailsPage.path,
                      extra: ProductDetailsExtra(details: product),
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
