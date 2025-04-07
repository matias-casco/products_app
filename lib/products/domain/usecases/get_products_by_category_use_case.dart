import 'package:fpdart/fpdart.dart';
import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

class GetProductsByCategoryUseCase
    extends UseCase<Products, GetProductsByCategoryUseCaseParams> {
  final ProductsRepository _productsRepository;

  GetProductsByCategoryUseCase({
    required ProductsRepository productsRepository,
  }) : _productsRepository = productsRepository;

  @override
  Future<Either<Failure, Products>> call(
      GetProductsByCategoryUseCaseParams params) async {
    return await _productsRepository.getProductsByCategory(slug: params.slug);
  }
}

class GetProductsByCategoryUseCaseParams {
  final String slug;

  const GetProductsByCategoryUseCaseParams({
    required this.slug,
  });
}
