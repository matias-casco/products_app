part of 'categories_list_cubit.dart';

enum CategoriesListStatus { initial, loading, loaded, error }

class CategoriesListState extends Equatable {
  const CategoriesListState({
    this.status = CategoriesListStatus.initial,
    this.categories,
    this.errorMessage,
  });

  final CategoriesListStatus? status;
  final List<Category>? categories;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        categories,
        errorMessage,
        status,
      ];

  CategoriesListState copyWith({
    CategoriesListStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return CategoriesListState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
