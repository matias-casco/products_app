import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:products_app/core/injector/injector.dart';
import 'package:products_app/products/presentation/notifiers/products_page_notifier.dart';
import 'package:products_app/products/presentation/pages/product_details_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const name = 'Products';
  static const path = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        bottom: PreferredSize(
          preferredSize: const Size(30, 20),
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: const Text(
              'Buy Best',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _productsNotifier = ProductsPageNotifier(getProductsUseCase: sl());

  @override
  void dispose() {
    _productsNotifier.dispose();
    super.dispose();
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
              height: 20,
            ),
            const Text('Ofertas imperdibles'),
            ValueListenableBuilder(
              valueListenable: _productsNotifier.productsState,
              builder: (context, state, child) {
                if (state.status == ProductsPageStatus.error) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      36,
                      12,
                      14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage ?? 'An error occurred'),
                        const SizedBox(
                          height: 14,
                        ),
                        FilledButton(
                          onPressed: () {
                            _productsNotifier.getProducts();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.red[400]),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.status == ProductsPageStatus.loading ||
                    state.status == null) {
                  return const Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }

                return Column(
                  children: List.generate(
                    state.products!.productsDetails.length,
                    (index) {
                      final product = state.products!.productsDetails[index];
                      return InkWell(
                        onTap: () {
                          context.push(ProductDetailsPage.path,
                              extra: ProductDetailsExtra(details: product));
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Image.network(
                                    product.thumbnail,
                                    width: 150,
                                    height: 150,
                                  ),
                                  ListTile(
                                    title: Text(product.title),
                                    subtitle: Text(product.description),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
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
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    color: Colors.amber,
                                    child: Text(
                                      '\$${product.price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
