import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/models/products/products_model.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/entities/products/products.dart';

import 'products_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsDatasource>(as: #MockProductsDatasource),
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

  group('ProductsRepositoryImpl', () {
    late ProductsRepositoryImpl productsRepositoryImpl;
    late MockProductsDatasource mockProductsDatasource;

    setUp(() {
      mockProductsDatasource = MockProductsDatasource();
      productsRepositoryImpl =
          ProductsRepositoryImpl(productsDatasource: mockProductsDatasource);
      provideDummy<Either<Failure, Products>>(Right(mockProductsEntity));
    });

    test('getProducts method should return a Right<Failure, Products>', () async {
      // Arrange
      when(mockProductsDatasource.getProducts())
          .thenAnswer((_) async => mockProductsModel);

      // Act
      final result = await productsRepositoryImpl.getProducts();

      // Assert
      expect(result, isA<Right<Failure, Products>>());
    });

    test('should return a Left<Failure, Products> when an exception occurs', () async {
      // Arrange
      when(mockProductsDatasource.getProducts()).thenThrow(Exception());

      // Act
      final result = await productsRepositoryImpl.getProducts();

      // Assert
      expect(result, isA<Left<Failure, Products>>());
    });
  });

}
