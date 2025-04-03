part of 'products_page_cubit.dart';

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
