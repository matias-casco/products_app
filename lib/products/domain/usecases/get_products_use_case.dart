import 'package:fpdart/fpdart.dart';
import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/domain/entities/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

class GetProductsUseCase extends UseCase<Products, NoParams> {
  final ProductsRepository _productsRepository;

  GetProductsUseCase({required ProductsRepository productsRepository,})
      : _productsRepository = productsRepository;

  @override
  Future<Either<Failure, Products>> call(NoParams params) async {
    return _productsRepository.getProducts();
  }
}