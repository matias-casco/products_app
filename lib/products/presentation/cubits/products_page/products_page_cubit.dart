import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

part 'products_page_state.dart';

class ProductsPageCubit extends Cubit<ProductsPageState> {
  ProductsPageCubit({
    required GetProductsUseCase getProductsUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        super(const ProductsPageState());

  final GetProductsUseCase _getProductsUseCase;

  Future<void> getProducts() async {
    
    if (state.status == ProductsPageStatus.loading) return;

    emit(state.copyWith(status: ProductsPageStatus.loading));

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
}
