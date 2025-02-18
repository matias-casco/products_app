import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/products.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

enum ProductsPageStatus {initial, loading, loaded, error }

class ProductsPageState extends Equatable {
  const ProductsPageState({
    this.status = ProductsPageStatus.initial,
    required this.products,
    required this.errorMessage,
    
  });

  final ProductsPageStatus? status;
  final Products? products;
  final String? errorMessage;

  @override
  List<Object?> get props => [products, errorMessage, status];

  ProductsPageState copyWith({
    ProductsPageStatus? status,
    Products? products,
    String? errorMessage,
  }) {
    return ProductsPageState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProductsPageNotifier extends ChangeNotifier {
  ProductsPageNotifier({
    required GetProductsUseCase getProductsUseCase,
  }) : _getProductsUseCase = getProductsUseCase {
    getProducts();
  }

  final GetProductsUseCase _getProductsUseCase;

  final ValueNotifier<ProductsPageState> productsState = ValueNotifier(
    const ProductsPageState(
      products: null,
      errorMessage: null,
    ),
  );

  @override
  void dispose() {
    productsState.dispose();
    super.dispose();
  }

  Future<void> getProducts() async {
    
    productsState.value = productsState.value.copyWith(status: ProductsPageStatus.loading);

    final result = await _getProductsUseCase(NoParams());

    result.fold(
      (failure) {
        productsState.value = productsState.value.copyWith(
          status: ProductsPageStatus.error,
          errorMessage: failure.message ?? 'An error occurred',
        );
      },
      (products) {
        if (products.productsDetails.isEmpty) {
          productsState.value = productsState.value.copyWith(
            status: ProductsPageStatus.error,
            errorMessage: 'No products found',
          );
          return;
        }

        productsState.value = productsState.value.copyWith(
          status: ProductsPageStatus.loaded,
          products: products,
        );
      },
    );
  }

  
}
