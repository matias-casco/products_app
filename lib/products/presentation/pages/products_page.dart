import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:products_app/core/blocs/internet_checker/internet_checker_bloc.dart';
import 'package:products_app/core/injector/injector.dart';
import 'package:products_app/products/presentation/cubits/products_page/products_page_cubit.dart';
import 'package:products_app/products/presentation/views/products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, this.categorySlug});

  static const name = 'Products';
  static const path = '/products';
  final String? categorySlug;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsPageCubit(
            getCategoriesUseCase: sl(),
            getProductsUseCase: sl(),
            getProductsByCategoryUseCase: sl(),
          )..init(
              categorySlug: categorySlug,
            ),
        ),
      ],
      child: BlocListener<InternetCheckerBloc, InternetCheckerState>(
        listenWhen: (previous, current) {
          if (current is ConnectedState) {
            return previous is NotConnectedState;
          }
          if (current is NotConnectedState) {
            return previous is ConnectedState;
          }
          return false;
        },
        listener: (context, state) {
          if (state is ConnectedState) {
            context.read<ProductsPageCubit>().getProducts();
          }
          if (state is NotConnectedState) {
            final snackBar = SnackBar(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              content: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.signal_wifi_connected_no_internet_4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'No internet connection',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                  ],
                ),
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(hours: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is ConnectedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: Scaffold(
          appBar: const _ProductsPageAppBar(),
          drawer: const _Drawer(),
          onDrawerChanged: (hasChanged) async {
            final name = hasChanged ? 'drawer_opened' : 'drawer_closed';

            await FirebaseAnalytics.instance.logEvent(
              name: name,
            );
          },
          body: const ProductsView(),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<ProductsPageCubit, ProductsPageState>(
              builder: (context, state) {
                if (state.categoriesStatus == CategoriesListStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.categoriesStatus == CategoriesListStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Something went wrong',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                if (state.categoriesStatus == CategoriesListStatus.loaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 4,
                    ),
                    itemCount: state.categories!.length,
                    itemBuilder: (context, index) {
                      final category = state.categories![index];
                      return ListTile(
                        title: Text(category.name),
                        onTap: () {
                          FirebaseAnalytics.instance.logEvent(
                              name: 'category_tap_drawer', parameters: {
                                category.name: category.name,
                                'category_slug': category.slug,
                                'category_index': index,
                              });
                          context.push(
                            '/products/${category.slug}',
                          );
                          context.pop();
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProductsPageAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      title: InkWell(
        onTap: () {
          context.go(
            '${ProductsPage.path}/all',
          );
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),
          child: Text(
            'Buy Today',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
