import 'package:flutter/widgets.dart';

import 'package:fpdart/fpdart.dart';

import 'package:products_app/core/errors/failures.dart';
import 'package:products_app/core/http_client/exceptions/exceptions.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/domain/entities/categories/categories.dart';
import 'package:products_app/products/domain/entities/products/products.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasource _productsDatasource;

  ProductsRepositoryImpl({required ProductsDatasource productsDatasource})
      : _productsDatasource = productsDatasource;

  @override
  Future<Either<Failure, Products>> getProducts() async {
    try {
      final products = await _productsDatasource.getProducts();
      return Right(
        products.toEntity(),
      );
    } on GenericException catch (e) {
      return Left(
        ServerFailure(
          code: e.code,
          message: e.readableOutput,
        ),
      );
    } on Exception catch (e) {
      debugPrint('${e.runtimeType} ${e.toString()}');
      return const Left(
        ServerFailure(
          code: ErrorCode.unexpected,
          message: 'An unexpected error occurred',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Categories>> getCategories() async {
     try {
      final categories = await _productsDatasource.getCategories();
      return Right(
        categories.toEntity(),
      );
    } on GenericException catch (e) {
      return Left(
        ServerFailure(
          code: e.code,
          message: e.readableOutput,
        ),
      );
    } on Exception catch (e) {
      debugPrint('${e.runtimeType} ${e.toString()}');
      return const Left(
        ServerFailure(
          code: ErrorCode.unexpected,
          message: 'An unexpected error occurred',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Products>> getProductsByCategory(
      {required String slug}) async {
    try {
      final products = await _productsDatasource.getProductsByCategory(slug: slug);
      return Right(
        products.toEntity(),
      );
    } on GenericException catch (e) {
      return Left(
        ServerFailure(
          code: e.code,
          message: e.readableOutput,
        ),
      );
    } on Exception catch (e) {
      debugPrint('${e.runtimeType} ${e.toString()}');
      return const Left(
        ServerFailure(
          code: ErrorCode.unexpected,
          message: 'An unexpected error occurred',
        ),
      );
    }
  }
}
