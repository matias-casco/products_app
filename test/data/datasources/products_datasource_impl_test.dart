import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/models/categories/categories_model.dart';
import 'package:products_app/products/data/models/products/products_model.dart';

import 'products_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpClientInterface>(as: #MockHttpClientInterface),
  MockSpec<ProductsDatasource>(as: #MockProductsDatasource),
  MockSpec<ProductsModel>(as: #MockProductsModel),
  MockSpec<CategoriesModel>(as: #MockCategoriesModel),
])
void main() {
  late MockHttpClientInterface mockHttpClientInterface;
  late MockProductsModel mockProductsModel;
  late MockCategoriesModel mockCategoriesModel;

  group('ProductsDatasourceImpl', () {
    late ProductsDatasourceImpl productsDatasourceImpl;

    setUp(() {
      mockHttpClientInterface = MockHttpClientInterface();
      mockProductsModel = MockProductsModel();
      mockCategoriesModel = MockCategoriesModel();
      productsDatasourceImpl =
          ProductsDatasourceImpl(client: mockHttpClientInterface);
    });

    test(
        'getProducts - should perform a GET request and return a products model',
        () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockProductsModel);

      // Act
      final result = await productsDatasourceImpl.getProducts();

      // Assert
      expect(result, isA<ProductsModel>());
    });

    test('getProducts - should handle errors when performing a GET request',
        () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: 'https://dummyjson.com/categories'),
        response: Response(
          statusCode: 400,
          requestOptions:
              RequestOptions(path: 'https://dummyjson.com/categories'),
          data: null,
        ),
      ));

      // Act & Assert
      expect(
        () async => await productsDatasourceImpl.getProducts(),
        throwsA(isA<DioException>()),
      );
    });

    test(
      'getCategories - should perform a GET request and return a CategoriesModel',
      () async {
        // Arrange
        when(mockHttpClientInterface.getRequest(
          any,
          converter: anyNamed('converter'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => mockCategoriesModel);

        // Act
        final result = await productsDatasourceImpl.getCategories();

        // Assert
        expect(result, isA<CategoriesModel>());
      },
    );

    test('getCategories - should handle errors when performing a GET request',
        () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: 'https://dummyjson.com/categories'),
        response: Response(
          statusCode: 400,
          requestOptions:
              RequestOptions(path: 'https://dummyjson.com/categories'),
          data: null,
        ),
      ));

      // Act & Assert
      expect(
        () async => await productsDatasourceImpl.getCategories(),
        throwsA(isA<DioException>()),
      );
    });

    test(
        'getProductsByCategory - should perform a GET request and return a products model',
        () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockProductsModel);

      // Act
      final result =
          await productsDatasourceImpl.getProductsByCategory(slug: 'slug');

      // Assert
      expect(result, isA<ProductsModel>());
    });

    test(
        'getProductsByCategory - should handle errors when performing a GET request',
        () async {
      // Arrange
      final slug = 'slug';

      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: 'https://dummyjson.com/categories/$slug'),
        response: Response(
          statusCode: 400,
          requestOptions:
              RequestOptions(path: 'https://dummyjson.com/categories/$slug'),
          data: null,
        ),
      ));

      // Act & Assert
      expect(
        () async =>
            await productsDatasourceImpl.getProductsByCategory(slug: slug),
        throwsA(isA<DioException>()),
      );
    });
  });

  //hacer pruebas para getProductsByCategory
}
