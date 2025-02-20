import 'package:flutter/material.dart';

import 'package:products_app/products/presentation/views/products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const name = 'Products';
  static const path = '/products';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _ProductsPageAppBar(),
      body: ProductsView(),
    );
  }
}

class _ProductsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
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
