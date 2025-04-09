// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:network_image_mock/network_image_mock.dart';

// import 'package:products_app/main.dart';
// import 'package:products_app/products/data/models/products/products_model.dart';
// import 'package:products_app/products/presentation/cubits/products_page/products_page_cubit.dart';
// import 'package:products_app/products/presentation/pages/product_details_page.dart';

// import '../../data/products_json_mock.dart';
// import 'products_page_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<ProductsPageCubit>(as: #MockProductsPageCubit),
//   MockSpec<FirebaseApp>(as: #MockFirebaseApp),
// ]) // <-- Genera mocks con valores por defecto
// void main() {
//   late MockProductsPageCubit mockProductsPageCubit;
//   final sl = GetIt.instance;

//   final mockProducts = ProductsModel.fromJson(productsJsonMock).toEntity();

//   setUp(() async {
//     mockProductsPageCubit = MockProductsPageCubit();

//     TestWidgetsFlutterBinding.ensureInitialized();


//     when(Firebase.initializeApp()).thenAnswer(
//       (_) async => MockFirebaseApp(),
//     );

//     when(mockProductsPageCubit.state).thenReturn(
//       const ProductsPageState(
//         status: ProductsPageStatus.initial,
//         products: null,
//         errorMessage: null,
//       ),
//     );

//     // if (!sl.isRegistered<ProductsPageNotifier>()) {
//     //   sl.registerLazySingleton<ProductsPageNotifier>(() => mockProductsPageCubit);
//     // } else {
//     //   sl.unregister<ProductsPageNotifier>();
//     //   sl.registerLazySingleton<ProductsPageNotifier>(() => mockProductsPageCubit);
//     // }
//   });

//   Widget createTestWidget() {
//     return const MyApp();
//   }

//   group('ProductPage', () {
//     testWidgets('Shows Buy Today text in AppBar', (tester) async {
//       when(mockProductsPageCubit.state).thenReturn(
//         const ProductsPageState(
//           status: ProductsPageStatus.loaded,
//           products: null,
//           errorMessage: null,
//         ),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pump();

//       expect(
//           find.descendant(
//             of: find.byType(AppBar),
//             matching: find.text('Buy Today'),
//           ),
//           findsOneWidget);
//     });

//     testWidgets('Shows a CircleProgressIndicator when loading page',
//         (tester) async {
//       when(mockProductsPageCubit.state).thenReturn(
//         const ProductsPageState(
//           status: ProductsPageStatus.loading,
//           products: null,
//           errorMessage: null,
//         ),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pump(const Duration(milliseconds: 100));

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });

//     testWidgets('Shows an error message when loading fails', (tester) async {
//       when(mockProductsPageCubit.state).thenReturn(
//         const ProductsPageState(
//           status: ProductsPageStatus.error,
//           products: null,
//           errorMessage: 'Error loading products',
//         ),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       expect(find.text('Error loading products'), findsOneWidget);
//       expect(find.text('Retry'), findsOneWidget);
//     });

//     testWidgets('Shows products when loaded', (tester) async {
//       when(mockProductsPageCubit.state).thenReturn(
//         ProductsPageState(
//           status: ProductsPageStatus.loaded,
//           products: mockProducts,
//           errorMessage: null,
//         ),
//       );

//       await mockNetworkImagesFor(() async {
//         await tester.pumpWidget(createTestWidget());
//         await tester.pump(const Duration(seconds: 1));
//       });

//       expect(
//           find.text(mockProducts.productsDetails.first.title), findsOneWidget);
//       expect(find.text(mockProducts.productsDetails.first.description),
//           findsOneWidget);
//     });

//     testWidgets('Navigate to ProductDetailsPage when tapping a product',
//         (tester) async {
//       when(mockProductsPageCubit.state).thenReturn(
//         ProductsPageState(
//           status: ProductsPageStatus.loaded,
//           products: mockProducts,
//           errorMessage: null,
//         ),
//       );

//       await mockNetworkImagesFor(() async {
//         await tester.pumpWidget(createTestWidget());
//         await tester.pump(const Duration(seconds: 1));

//         await tester.tap(find.text(mockProducts.productsDetails.first.title));
//         await tester.pump();
//         await tester.pump(const Duration(milliseconds: 500));
//         await tester.pump(const Duration(milliseconds: 500));
//       });

//       expect(find.byType(ProductDetailsPage), findsOneWidget);
//     });
//   });
// }
