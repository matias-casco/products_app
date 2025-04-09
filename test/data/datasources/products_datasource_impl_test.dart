import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/http_client/interceptors/interceptors.dart';
import 'package:products_app/core/logger/logger.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/models/categories/categories_model.dart';
import 'package:products_app/products/data/models/products/products_model.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

import '../products_json_mock.dart';
import 'products_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpClientInterface>(as: #MockHttpClientInterface),
  MockSpec<ProductsDatasource>(as: #MockProductsDatasource),
  MockSpec<ProductsRepository>(as: #MockProductsRepository),
  MockSpec<ProductsModel>(as: #MockProductsModel),
  MockSpec<CategoriesModel>(as: #MockCategoriesModel),
])
void main() {
  late MockHttpClientInterface mockHttpClientInterface;
  late MockProductsModel mockProductsModel;
  late MockCategoriesModel mockCategoriesModel;

  setUpAll(() {
    mockHttpClientInterface = MockHttpClientInterface();
    mockProductsModel = MockProductsModel();
    mockCategoriesModel = MockCategoriesModel();
  });

  group('DioHttpClientImpl', () {
    late DioHttpClientImpl dioHttpClientImpl;

    setUp(() {
      dioHttpClientImpl = DioHttpClientImpl(
        logger: LoggerImpl(),
        dioClientExceptionInterceptor: DioClientExceptionInterceptor(),
        errorInterceptor: ErrorInterceptor(),
        internetCheckerInterceptor: InternetCheckerInterceptor(),
      );
      provideDummy<ProductsModel>(mockProductsModel);
    });

    test('should perform a GET request and return a Product model', () async {
      //Arrange
      final jsonMock = productsJsonMock;

      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenAnswer((json) async => jsonMock);

      // Act
      final result = await dioHttpClientImpl.getRequest<ProductsModel>(
        'https://dummyjson.com/products',
        converter: (json) => ProductsModel.fromJson(jsonMock),
      );

      // Assert
      expect(result, isA<ProductsModel>());
    });

    test('should handle errors when performing a GET request', () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'https://dummyjson.com/products'),
        response: Response(
          statusCode: 400,
          requestOptions:
              RequestOptions(path: 'https://dummyjson.com/products'),
          data: null,
        ),
      ));

      // Act & Assert
      expect(
        () async => await mockHttpClientInterface.getRequest<ProductsModel>(
          'https://dummyjson.com/products',
          converter: (json) => ProductsModel.fromJson(json),
        ),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('ProductsDatasourceImpl', () {
    late ProductsDatasourceImpl productsDatasourceImpl;

    setUp(() {
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
