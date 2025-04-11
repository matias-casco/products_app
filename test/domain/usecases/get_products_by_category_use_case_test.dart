import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/products/data/models/products/products_model.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_products_by_category_use_case.dart';

import 'get_products_by_category_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsRepository>(as: #MockProductsRepository),
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

  group('GetProductsByCategoryUseCase', () {
    late MockProductsRepository mockProductsRepository;
    late GetProductsByCategoryUseCase getProductsByCategoryUseCase;

    setUp(() {
      mockProductsRepository = MockProductsRepository();
      getProductsByCategoryUseCase = GetProductsByCategoryUseCase(
          productsRepository: mockProductsRepository);
      provideDummy<Either<Failure, Products>>(Right(mockProductsEntity));
    });

    test('should return a Right<Failure, Products> when calling succesfully',
        () async {
      // Arrange
      when(mockProductsModel.toEntity()).thenReturn(mockProductsEntity);
      when(mockProductsRepository.getProductsByCategory(slug: 'slug'))
          .thenAnswer((_) async => Right(mockProductsEntity));

      // Act
      final result = await getProductsByCategoryUseCase(
        const GetProductsByCategoryUseCaseParams(slug: 'slug'),
      );

      // Assert
      expect(result, isA<Right<Failure, Products>>());
    });

    test('should return a Left<Failure, Products> when an error occurs in repositorys', () async {
      // Arrange
      when(mockProductsRepository.getProductsByCategory(slug: 'slug'))
          .thenAnswer((_) async => const Left(ServerFailure()));

      // Act
      final result = await getProductsByCategoryUseCase(
        const GetProductsByCategoryUseCaseParams(slug: 'slug'),
      );

      // Assert
      expect(result, isA<Left<Failure, Products>>());
    });
  });
}
