import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:products_app/core/router/app_router.dart';
import 'package:products_app/products/data/models/products_model.dart';
import 'package:products_app/products/presentation/notifiers/products_page_notifier.dart';
import 'package:products_app/products/presentation/pages/product_details_page.dart';

import '../../data/products_json_mock.dart';
import 'products_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsPageNotifier>(as: #MockProductsPageNotifier)
]) // <-- Genera mocks con valores por defecto
void main() {
  late MockProductsPageNotifier mockNotifier;
  final sl = GetIt.instance;

  final mockProducts = ProductsModel.fromJson(productsJsonMock).toEntity();

  setUp(() async {
    mockNotifier = MockProductsPageNotifier();

    TestWidgetsFlutterBinding.ensureInitialized();

    mockNotifier = MockProductsPageNotifier();

    when(mockNotifier.productsState).thenReturn(ValueNotifier(
      const ProductsPageState(
        status: ProductsPageStatus.initial,
        products: null,
        errorMessage: null,
      ),
    ));

    if (!sl.isRegistered<ProductsPageNotifier>()) {
      sl.registerLazySingleton<ProductsPageNotifier>(() => mockNotifier);
    } else {
      sl.unregister<ProductsPageNotifier>();
      sl.registerLazySingleton<ProductsPageNotifier>(() => mockNotifier);
    }
  });

  tearDown(() {
    if (sl.isRegistered<ProductsPageNotifier>()) {
      sl.unregister<ProductsPageNotifier>();
    }
  });

  Widget createTestWidget() {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }

  group('ProductPage', () {
    testWidgets('Shows Buy Today text in AppBar', (tester) async {
      when(mockNotifier.productsState).thenReturn(ValueNotifier(
        const ProductsPageState(
          status: ProductsPageStatus.loaded,
          products: null,
          errorMessage: null,
        ),
      ));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Buy Today'),
          ),
          findsOneWidget);
    });

    testWidgets('Shows a CircleProgressIndicator when loading page',
        (tester) async {
      when(mockNotifier.productsState).thenReturn(ValueNotifier(
        const ProductsPageState(
          status: ProductsPageStatus.loading,
          products: null,
          errorMessage: null,
        ),
      ));

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows an error message when loading fails', (tester) async {
      when(mockNotifier.productsState).thenReturn(ValueNotifier(
        const ProductsPageState(
          status: ProductsPageStatus.error,
          products: null,
          errorMessage: 'Error loading products',
        ),
      ));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Error loading products'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('Shows products when loaded', (tester) async {
      when(mockNotifier.productsState).thenReturn(ValueNotifier(
        ProductsPageState(
          status: ProductsPageStatus.loaded,
          products: mockProducts,
          errorMessage: null,
        ),
      ));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
      });

      expect(
          find.text(mockProducts.productsDetails.first.title), findsOneWidget);
      expect(find.text(mockProducts.productsDetails.first.description),
          findsOneWidget);
    });

    testWidgets('Navigate to ProductDetailsPage when tapping a product',
        (tester) async {
      when(mockNotifier.productsState).thenReturn(ValueNotifier(
        ProductsPageState(
          status: ProductsPageStatus.loaded,
          products: mockProducts,
          errorMessage: null,
        ),
      ));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
      });

      await tester.tap(find.text(mockProducts.productsDetails.first.title));
      await tester.pumpAndSettle();

      expect(find.byType(ProductDetailsPage), findsOneWidget);
    });
  });
}
