
import 'package:fpdart/fpdart.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/products/domain/entities/categories/categories.dart';
import 'package:products_app/products/domain/entities/products/products.dart';

abstract class ProductsRepository {
  Future<Either<Failure, Products>> getProducts();
  Future<Either<Failure, Categories>> getCategories();
  Future<Either<Failure, Products>> getProductsByCategory({required String slug});
}