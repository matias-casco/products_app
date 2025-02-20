import 'package:get_it/get_it.dart';
import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/usecases/use_case.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';
import 'package:products_app/products/presentation/notifiers/products_page_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // http client
  sl.registerLazySingleton<HttpClientInterface>(() => DioHttpClientImpl());

  // products
  sl.registerLazySingleton<ProductsDatasource>(
      () => ProductsDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(productsDatasource: sl()));

  sl.registerLazySingleton<UseCase>(
      () => GetProductsUseCase(productsRepository: sl()));

  sl.registerFactory<ProductsPageNotifier>(() => ProductsPageNotifier(getProductsUseCase: sl()));
}
