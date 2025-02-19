import 'package:get_it/get_it.dart';
import 'package:products_app/core/http_client/dio_http_client_impl.dart';
import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/http_client/isolate_parser.dart';
import 'package:products_app/products/data/datasources/products_datasource.dart';
import 'package:products_app/products/data/repositories/products_repository_impl.dart';
import 'package:products_app/products/domain/repositories/products_repository.dart';
import 'package:products_app/products/domain/usecases/get_products_use_case.dart';

final sl = GetIt.instance;


Future<void> init() async {
  // http client
  sl.registerFactory<HttpClientInterface>(() => DioHttpClientImpl());

  // products
  sl.registerFactory<ProductsDatasource>(
      () => ProductsDatasourceImpl(client: sl()));

  sl.registerFactory<ProductsRepository>(
      () => ProductsRepositoryImpl(productsDatasource: sl()));

  sl.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(productsRepository: sl()));

}
