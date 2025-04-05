import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/core/blocs/internet_checker/internet_checker_bloc.dart';

import 'package:products_app/core/injector/injector.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';
import 'package:products_app/products/presentation/cubits/products_page/products_page_cubit.dart';
import 'package:products_app/products/presentation/views/products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const name = 'Products';
  static const path = '/products';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsPageCubit(
        getProductsUseCase: GetProductsUseCase(
          productsRepository: sl(),
        ),
      )..getProducts(),
      child: BlocListener<InternetCheckerBloc, InternetCheckerState>(
        //escuchar solo cuando el estado sea diferente al anterior
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
          if (state is ConnectedState){
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
        child: const Scaffold(
          appBar: _ProductsPageAppBar(),
          body: ProductsView(),
        ),
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
      title: Container(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
