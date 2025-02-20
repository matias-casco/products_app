import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/models/products_model.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

import '../products_json_mock.dart';
import 'products_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpClientInterface>(as: #MockHttpClientInterface),
  MockSpec<ProductsDatasource>(as: #MockProductsDatasource),
  MockSpec<ProductsRepository>(as: #MockProductsRepository),
  MockSpec<ProductsModel>(as: #MockProductsModel),
])
void main() {
  late MockHttpClientInterface mockHttpClientInterface;
  late MockProductsModel mockProductsModel;

  setUpAll(() {
    mockHttpClientInterface = MockHttpClientInterface();
    mockProductsModel = MockProductsModel();
  });

  group('DioHttpClientImpl', () {
    late DioHttpClientImpl dioHttpClientImpl;

    setUp(() {
      dioHttpClientImpl = DioHttpClientImpl();
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
        converter: (json) =>
            ProductsModel.fromJson(jsonMock),
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

    test('should perform a GET request and return a product model', () async {
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
        () async => await productsDatasourceImpl.getProducts(),
        throwsA(isA<DioException>()),
      );
    });
  });

}
