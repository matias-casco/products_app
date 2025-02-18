import 'package:fpdart/fpdart.dart';
import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/products/domain/entities/products.dart';

abstract class ProductsRepository {
  Future<Either<Failure, Products>> getProducts();
}