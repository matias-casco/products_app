import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/models/products_model.dart';
import 'package:products_app/products/domain/entities/products.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';
import 'package:products_app/products/presentation/notifiers/products_page_notifier.dart';

import '../../data/products_json_mock.dart';

import 'products_page_notifier_test.mocks.dart';


@GenerateNiceMocks([
  MockSpec<GetProductsUseCase>(as: #MockGetProductsUseCase),
  MockSpec<ProductsModel>(as: #MockProductsModel),
  MockSpec<Products>(as: #MockProducts),
])
void main() {
  late MockProductsModel mockProductsModel;
  late MockProducts mockProductsEntity;

  setUpAll(() {
    mockProductsModel = MockProductsModel();
    mockProductsEntity = MockProducts();
  });
  group('ProductsPageNotifier', () {
    late MockGetProductsUseCase mockGetProductsUseCase;
    late ProductsPageNotifier productsPageNotifier;
    late dynamic jsonMock;

    setUp(() {
      mockGetProductsUseCase = MockGetProductsUseCase();
      productsPageNotifier =
          ProductsPageNotifier(getProductsUseCase: mockGetProductsUseCase);
      provideDummy<Either<Failure, Products>>(Right(mockProductsEntity));
      jsonMock = productsJsonMock;
    });

    test('should load a product entity', () async {
      // Arrange
      when(mockProductsModel.toEntity()).thenReturn(mockProductsEntity);
      when(mockGetProductsUseCase(NoParams())).thenAnswer(
          (_) async => Right(ProductsModel.fromJson(jsonMock).toEntity()));

      // Act
      await productsPageNotifier.getProducts();

      // Assert
      expect(
          productsPageNotifier.productsState.products, isA<Products>());

      expect(productsPageNotifier.productsState.status,
          ProductsPageStatus.loaded);
    });

    test('should return a failure when an exception occurs', () async {
      // Arrange
      when(mockGetProductsUseCase(NoParams())).thenAnswer((_) async =>
          const Left(ServerFailure(
              message: 'An error occurred while fetching products')));

      // Act
      await productsPageNotifier.getProducts();

      // Assert
      expect(productsPageNotifier.productsState.status,
          ProductsPageStatus.error);
    });

    tearDown(() {
      productsPageNotifier.dispose();
    });
  });
  
}
