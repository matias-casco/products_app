import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/products.dart';

enum ProductsPageStatus { initial, loading, loaded, error }

class ProductsPageState extends Equatable {
  const ProductsPageState({
    this.status = ProductsPageStatus.initial,
    this.products,
    this.errorMessage,
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
    required UseCase getProductsUseCase,
  }) : _getProductsUseCase = getProductsUseCase;

  final UseCase _getProductsUseCase;

  ProductsPageState productsState = const ProductsPageState();

  Future<void> getProducts() async {
    productsState = productsState.copyWith(status: ProductsPageStatus.loading);
    notifyListeners();

    final result = await _getProductsUseCase(NoParams());

    result.fold(
      (failure) {
        productsState = productsState.copyWith(
          status: ProductsPageStatus.error,
          errorMessage: failure.message ?? 'An error occurred',
        );
        notifyListeners();
      },
      (products) {
        if (products.productsDetails.isEmpty) {
          productsState = productsState.copyWith(
            status: ProductsPageStatus.error,
            errorMessage: 'No products found',
          );
          notifyListeners();
          return;
        }

        productsState = productsState.copyWith(
          status: ProductsPageStatus.loaded,
          products: products,
        );

        notifyListeners();
      },
    );
  }
}
