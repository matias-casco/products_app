

import 'package:fpdart/fpdart.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/categories/category.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

class GetCategoriesUseCase extends UseCase<List<Category>, NoParams> {
  final ProductsRepository _productsRepository;

  GetCategoriesUseCase({required ProductsRepository productsRepository,})
      : _productsRepository = productsRepository;

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await _productsRepository.getCategories();
  }
}