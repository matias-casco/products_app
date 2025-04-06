import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/categories/category.dart';
import 'package:products_app/products/domain/usecases/get_categories_use_case.dart';

part 'categories_list_state.dart';

class CategoriesListCubit extends Cubit<CategoriesListState> {
  CategoriesListCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        super(const CategoriesListState());

  final GetCategoriesUseCase _getCategoriesUseCase;

  void getCategories() async {
    emit(state.copyWith(status: CategoriesListStatus.loading));
    final result = await _getCategoriesUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: CategoriesListStatus.error,
        errorMessage: failure.message,
      )),
      (categories) => emit(state.copyWith(
        status: CategoriesListStatus.loaded,
        categories: categories,
      )),
    );
  }
}
