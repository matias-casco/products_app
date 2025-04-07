import 'package:go_router/go_router.dart';

import 'package:products_app/products/presentation/pages/product_details_page.dart';
import 'package:products_app/products/presentation/pages/products_page.dart';

final appRouter = GoRouter(
  initialLocation: '${ProductsPage.path}/all',
  routes: [
    GoRoute(
      path: '${ProductsPage.path}/:categorySlug',
      name: ProductsPage.name,
      builder: (context, state) {
        final categorySlug = state.pathParameters['categorySlug'] ?? 'all';

        return ProductsPage(
          categorySlug: categorySlug,
        );
      },
    ),
    GoRoute(
      path: ProductDetailsPage.path,
      name: ProductDetailsPage.name,
      builder: (context, state) {
        if (state.extra == null) throw GoException('extra is required');

        return ProductDetailsPage(extra: state.extra as ProductDetailsExtra);
      },
    ),
    GoRoute(
      path: ProductsPage.path,
      redirect: (_, __) => ProductsPage.path,
    ),
  ],
);
