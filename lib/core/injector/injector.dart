import 'package:get_it/get_it.dart';

import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/http_client/interceptors/interceptors.dart';
import 'package:products_app/core/logger/logger.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_categories_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_by_category_use_case.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // logger
  sl.registerLazySingleton<Logger>(
    () => LoggerImpl(),
  );
  sl.registerLazySingleton(
    () => DioClientExceptionInterceptor(),
  );
  sl.registerLazySingleton(
    () => ErrorInterceptor(),
  );
  sl.registerLazySingleton(
    () => InternetCheckerInterceptor(),
  );

  // http client
  sl.registerLazySingleton<HttpClientInterface>(
    () => DioHttpClientImpl(
      logger: sl<Logger>(),
      dioClientExceptionInterceptor: sl(),
      errorInterceptor: sl(),
      internetCheckerInterceptor: sl(),
    ),
  );

  // products
  sl.registerLazySingleton<ProductsDatasource>(
      () => ProductsDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(productsDatasource: sl()));

  sl.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(productsRepository: sl()));

  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(productsRepository: sl()),
  );

  sl.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(productsRepository: sl()),
  );
}
