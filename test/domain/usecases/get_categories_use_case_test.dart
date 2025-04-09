import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/models/categories/categories_model.dart';
import 'package:products_app/products/domain/entities/categories/categories.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_categories_use_case.dart';

import 'get_categories_use_case_test.mocks.dart';


@GenerateNiceMocks([
  MockSpec<ProductsRepository>(as: #MockProductsRepository),
  MockSpec<CategoriesModel>(as: #MockCategoriesModel),
  MockSpec<Categories>(as: #MockCategories),
])
void main() {
  late MockCategoriesModel mockCategoriesModel;
  late MockCategories mockCategoriesEntity;

  setUpAll(() {
    mockCategoriesModel = MockCategoriesModel();
    mockCategoriesEntity = MockCategories();
  });

  group('getCategoriesUseCase', () {
    late MockProductsRepository mockProductsRepository;
    late GetCategoriesUseCase getCategoriesUseCase;

    setUp(() {
      mockProductsRepository = MockProductsRepository();
      getCategoriesUseCase =
          GetCategoriesUseCase(productsRepository: mockProductsRepository);
      provideDummy<Either<Failure, Categories>>(Right(mockCategoriesEntity));
    });

    test('should return a Right<Failure, Categories> when calling succesfully', () async {
      // Arrange
      when(mockCategoriesModel.toEntity()).thenReturn(mockCategoriesEntity);
      when(mockProductsRepository.getCategories())
          .thenAnswer((_) async => Right(mockCategoriesEntity));

      // Act
      final result = await getCategoriesUseCase(NoParams());

      // Assert
      expect(result, isA<Right<Failure, Categories>>());
    });

  });
}
