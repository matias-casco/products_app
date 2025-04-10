import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/models/categories/categories_model.dart';
import 'package:products_app/products/data/models/products/products_model.dart';
import 'package:products_app/products/domain/entities/categories/categories.dart';
import 'package:products_app/products/domain/entities/categories/category.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/usecases/get_categories_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_by_category_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';
import 'package:products_app/products/presentation/cubits/products_page/products_page_cubit.dart';

import '../../data/categories_json_mock.dart';
import '../../data/products_json_mock.dart';

import 'products_page_cubit_test.mocks.dart';



@GenerateNiceMocks([
  MockSpec<GetProductsUseCase>(as: #MockGetProductsUseCase),
  MockSpec<GetCategoriesUseCase>(as: #MockGetCategoriesUseCase),
  MockSpec<GetProductsByCategoryUseCase>(as: #MockGetProductsByCategoryUseCase),
  MockSpec<ProductsModel>(as: #MockProductsModel),
  MockSpec<CategoriesModel>(as: #MockCategoriesModel),
  MockSpec<Products>(as: #MockProducts),
  MockSpec<Categories>(as: #MockCategories),
])
void main() {
  late MockProductsModel mockProductsModel;
  late MockProducts mockProductsEntity;
  late MockCategoriesModel mockCategoriesModel;
  late MockCategories mockCategoriesEntity;

  setUpAll(() {
    mockProductsModel = MockProductsModel();
    mockProductsEntity = MockProducts();
    mockCategoriesModel = MockCategoriesModel();
    mockCategoriesEntity = MockCategories();
  });
  group('Products Page Cubit', () {
    late MockGetProductsUseCase mockGetProductsUseCase;
    late MockGetCategoriesUseCase mockGetCategoriesUseCase;
    late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;
    late ProductsPageCubit productsPageCubit;
    final dynamic myProductsJsonMock = productsJsonMock;
    final dynamic myCategoriesJsonMock = categoriesJsonMock;

    setUp(() {
      mockGetProductsUseCase = MockGetProductsUseCase();
      mockGetCategoriesUseCase = MockGetCategoriesUseCase();
      mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
      productsPageCubit =
          ProductsPageCubit(getProductsUseCase: mockGetProductsUseCase,
          getCategoriesUseCase: mockGetCategoriesUseCase,
          getProductsByCategoryUseCase: mockGetProductsByCategoryUseCase,
          );
      provideDummy<Either<Failure, Products>>(Right(mockProductsEntity));
      provideDummy<Either<Failure, Categories>>(Right(mockCategoriesEntity));
    });

    test('getProducts should load a Products entity and set ProductPageStatus.loaded', () async {
      // Arrange
      when(mockProductsModel.toEntity()).thenReturn(mockProductsEntity);
      when(mockGetProductsUseCase(NoParams())).thenAnswer(
          (_) async => Right(ProductsModel.fromJson(myProductsJsonMock).toEntity()));

      // Act
      await productsPageCubit.getProducts();

      // Assert
      expect(
          productsPageCubit.state.products, isA<Products>());

      expect(productsPageCubit.state.status,
          ProductsPageStatus.loaded);
    });

    test('getProducts should return a failure when an exception occurs and set ProductPageStatus.error', () async {
      // Arrange
      when(mockGetProductsUseCase(NoParams())).thenAnswer((_) async =>
          const Left(ServerFailure(
              message: 'An error occurred while fetching products')));

      // Act
      await productsPageCubit.getProducts();

      // Assert
      expect(productsPageCubit.state.status,
          ProductsPageStatus.error);
    });

     test('getCategories should load a Categories entity and set CategoriesListStatus.loaded', () async {
      // Arrange
      when(mockCategoriesModel.toEntity()).thenReturn(mockCategoriesEntity);
      when(mockGetCategoriesUseCase(NoParams())).thenAnswer(
          (_) async => Right(CategoriesModel.fromJson(myCategoriesJsonMock).toEntity()));

      // Act
      await productsPageCubit.getCategories();

      // Assert
      expect(
          productsPageCubit.state.categories, isA<List<Category>>());

      expect(productsPageCubit.state.categoriesStatus,
          CategoriesListStatus.loaded);
    });

    test('getCategories should return a failure when an exception occurs and set CategoriesListStatus.error', () async {
      // Arrange
      when(mockGetCategoriesUseCase(NoParams())).thenAnswer((_) async =>
          const Left(ServerFailure(
              message: 'An error occurred while fetching products')));

      // Act
      await productsPageCubit.getCategories();

      // Assert
      expect(productsPageCubit.state.categoriesStatus,
          CategoriesListStatus.error);
    });

    tearDown(() {
      productsPageCubit.close();
    });
  });
  
}
