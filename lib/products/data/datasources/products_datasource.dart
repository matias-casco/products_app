import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/products/data/models/products_model.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getProducts();
}

class ProductsDatasourceImpl implements ProductsDatasource {
  ProductsDatasourceImpl({required HttpClientInterface client})
      : _client = client;

  final HttpClientInterface _client;

  @override
  Future<ProductsModel> getProducts() async {
    try {
    return _client.getRequest<ProductsModel>(
      '/products?limit=12',
      converter: (json) => ProductsModel.fromJson(json),
    );
    } catch (_) {
      rethrow;
    }
  }
}
