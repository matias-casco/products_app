part of 'products_page_cubit.dart';

enum ProductsPageStatus { initial, loading, loaded, error }

enum CategoriesListStatus { initial, loading, loaded, error }

class ProductsPageState extends Equatable {
  const ProductsPageState({
    this.status = ProductsPageStatus.initial,
    this.categoriesStatus = CategoriesListStatus.initial,
    this.products,
    this.errorMessage,
    this.categories,
    this.title = 'Special Offers',
  });

  final ProductsPageStatus? status;
  final CategoriesListStatus? categoriesStatus;
  final Products? products;
  final String? errorMessage;
  final String title;
  final List<Category>? categories;

  @override
  List<Object?> get props => [
        products,
        errorMessage,
        status,
        title,
        categories,
        categoriesStatus,
      ];

  ProductsPageState copyWith({
    ProductsPageStatus? status,
    Products? products,
    String? errorMessage,
    String? title,
    List<Category>? categories,
    CategoriesListStatus? categoriesStatus,
  }) {
    return ProductsPageState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      title: title ?? this.title,
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }
}
