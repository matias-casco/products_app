import 'package:go_router/go_router.dart';
import 'package:products_app/products/presentation/pages/product_details.dart';
import 'package:products_app/products/presentation/pages/products_page.dart';

final appRouter = GoRouter(initialLocation: ProductsPage.path, routes: [
  GoRoute(
    path: ProductsPage.path,
    name: ProductsPage.name,
    builder: (context, state) {
      return const ProductsPage();
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
]);
