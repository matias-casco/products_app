import 'package:get_it/get_it.dart';

import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/logger/logger.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {

   // logger
  sl.registerLazySingleton<Logger>(
    () => LoggerImpl(),
  );

  // http client
  sl.registerLazySingleton<HttpClientInterface>(
    () => DioHttpClientImpl(logger: sl<Logger>()),
  );

  // products
  sl.registerLazySingleton<ProductsDatasource>(
      () => ProductsDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(productsDatasource: sl()));

  sl.registerLazySingleton<UseCase>(
      () => GetProductsUseCase(productsRepository: sl()));
}
