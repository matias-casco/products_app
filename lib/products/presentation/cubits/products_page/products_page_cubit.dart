import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/categories/category.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/usecases/get_categories_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_by_category_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

part 'products_page_state.dart';

class ProductsPageCubit extends Cubit<ProductsPageState> {
  ProductsPageCubit({
    required GetProductsUseCase getProductsUseCase,
    required GetProductsByCategoryUseCase getProductsByCategoryUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        _getProductsByCategoryUseCase = getProductsByCategoryUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(const ProductsPageState());

  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> init({required String? categorySlug}) async {
      await getCategories();

    if (categorySlug == 'all') {
      getProducts();
    } else {
      final category = state.categories?.firstWhere(
        (category) => category.slug == categorySlug,
      );
      if (category != null) {
        await getProductsByCategory(category: category);
      } else {
        emit(
          state.copyWith(
            status: ProductsPageStatus.error,
            errorMessage: 'Category not found',
          ),
        );
      }
    }
  }

  Future<void> getProducts() async {
    if (state.status == ProductsPageStatus.loading) return;

    emit(state.copyWith(
      status: ProductsPageStatus.loading,
      title: 'Special Offers',
    ));

    final result = await _getProductsUseCase(NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ProductsPageStatus.error,
            errorMessage: failure.message ?? 'An error occurred',
          ),
        );
      },
      (products) {
        if (products.productsDetails.isEmpty) {
          emit(
            state.copyWith(
              status: ProductsPageStatus.error,
              errorMessage: 'No products found',
            ),
          );
          return;
        }

        emit(state.copyWith(
          status: ProductsPageStatus.loaded,
          products: products,
        ));
      },
    );
  }

  Future<void> getProductsByCategory({required Category category}) async {
    if (state.status == ProductsPageStatus.loading) return;

    emit(
      state.copyWith(
        status: ProductsPageStatus.loading,
        title: category.name,
      ),
    );

    final result = await _getProductsByCategoryUseCase(
      GetProductsByCategoryUseCaseParams(slug: category.slug),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ProductsPageStatus.error,
            errorMessage: failure.message ?? 'An error occurred',
          ),
        );
      },
      (products) {
        if (products.productsDetails.isEmpty) {
          emit(
            state.copyWith(
              status: ProductsPageStatus.error,
              errorMessage: 'No products found',
            ),
          );
          return;
        }

        emit(state.copyWith(
          status: ProductsPageStatus.loaded,
          products: products,
        ));
      },
    );
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: CategoriesListStatus.loading));
    final result = await _getCategoriesUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        categoriesStatus: CategoriesListStatus.error,
        errorMessage: failure.message,
      )),
      (categories) => emit(state.copyWith(
        categoriesStatus: CategoriesListStatus.loaded,
        categories: categories,
      )),
    );
  }
}
