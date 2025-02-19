import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/models/products_model.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/entities/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

import 'models/products_model_mock.dart';
import 'unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpClientInterface>(as: #MockHttpClientInterface),
  MockSpec<ProductsDatasource>(as: #MockProductsDatasource),
  MockSpec<ProductsRepository>(as: #MockProductsRepository),
  MockSpec<ProductsModel>(as: #MockProductsModel),
])
void main() {
  late MockHttpClientInterface mockHttpClientInterface;
  late MockProductsDatasource mockProductsDatasource;
  late MockProductsRepository mockProductsRepository;
  late MockProductsModel mockProductsModel;

  setUpAll(() {
    mockHttpClientInterface = MockHttpClientInterface();
    mockProductsModel = MockProductsModel();
    mockProductsDatasource = MockProductsDatasource();
    mockProductsRepository = MockProductsRepository();
  });

  group('HttpClientInterface - Solicitudes HTTP', () {
    test('debe hacer una solicitud GET y devolver un modelo de productos',
        () async {
      // Arrange
      when(mockHttpClientInterface.getRequest(
        any,
        converter: anyNamed('converter'),
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockProductsModel);

      // Act
      final result = await mockHttpClientInterface.getRequest<ProductsModel>(
        'https://dummyjson.com/products',
        converter: (json) => ProductsModel.fromJson(json),
      );

      // Assert
      expect(result, isA<ProductsModel>());
    });

    test('debe manejar errores al hacer una solicitud GET', () async {
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

  group('ProductsDatasource - Fuente de datos de productos', () {
    late ProductsDatasourceImpl productsDatasourceImpl;

    setUp(() {
      productsDatasourceImpl =
          ProductsDatasourceImpl(client: mockHttpClientInterface);
    });

    test('debe hacer una solicitud GET y devolver un modelo de productos',
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

    test('debe manejar errores al hacer una solicitud GET', () async {
      // Arrange
      when(mockProductsDatasource.getProducts()).thenThrow(DioException(
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
        () async => await mockProductsDatasource.getProducts(),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('ProductsRepository - Repositorio de productos', () {
    late ProductsRepositoryImpl productsRepositoryImpl;

    setUp(() {
      productsRepositoryImpl = ProductsRepositoryImpl(
        productsDatasource: mockProductsDatasource,
      );
    });

    test('debe devolver una entidad de productos', () async {
      // Arrange
      when(mockProductsDatasource.getProducts())
          .thenAnswer((_) async => mockProductsModel);

      // Act
      final result = await productsRepositoryImpl.getProducts();

      // Assert
      expect(result, isA<Right<Failure, Products>>());
    });
  });

  group('GetProductsUseCase - Caso de uso para obtener productos', () {
    late GetProductsUseCase getProductsUseCase;
    // Arrange
    setUp(() {
      getProductsUseCase =
          GetProductsUseCase(productsRepository: mockProductsRepository);
      provideDummy<Either<Failure, Products>>(Right(mockProductsModel.toEntity()));
    });

    test('debe devolver una entidad de productos', () async {
      when(mockProductsRepository.getProducts())
          .thenAnswer((_) async => Right(mockProductsModel.toEntity()));

      // Act
      final result = await getProductsUseCase(NoParams());

      // Assert
      expect(result, isA<Right<Failure, Products>>());
    });
  });
}
