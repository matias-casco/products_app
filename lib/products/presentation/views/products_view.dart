import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:products_app/products/presentation/cubits/products_page/products_page_cubit.dart';
import 'package:products_app/products/presentation/pages/product_details_page.dart';
import 'package:products_app/products/presentation/widgets/product_card.dart';
import 'package:products_app/products/presentation/widgets/widgets.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.read<ProductsPageCubit>().getProducts();
        return Future.value();
      },
      child: const _ProductsBuilder(),
    );
  }
}

class _ProductsBuilder extends StatelessWidget {
  const _ProductsBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsPageCubit, ProductsPageState>(
      builder: (context, state) {
        if (state.status == ProductsPageStatus.error) {
          return ErrorMessageContainer(
            errorMessage: state.errorMessage,
            onRetryPressed: () {
              context.read<ProductsPageCubit>().getProducts();
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

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Special Offers',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.products!.productsDetails.length,
                (context, index) {
                  final product = state.products!.productsDetails[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      context.push(
                        ProductDetailsPage.path,
                        extra: ProductDetailsExtra(details: product),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
