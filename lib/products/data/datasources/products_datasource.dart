import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/products/data/models/categories/categories_model.dart';
import 'package:products_app/products/data/models/products/products_model.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getProducts({int limit = 24, int skip = 0});
  Future<CategoriesModel> getCategories();
  Future<ProductsModel> getProductsByCategory({required String slug});
}

class ProductsDatasourceImpl implements ProductsDatasource {
  ProductsDatasourceImpl({required HttpClientInterface client})
      : _client = client;

  final HttpClientInterface _client;

  @override
  Future<ProductsModel> getProducts({int limit = 24, int skip = 0}) async {
    return await _client.getRequest(
      '/products?limit=$limit&skip=$skip',
      converter: (json) => ProductsModel.fromJson(json),
    );
  }

  @override
  Future<CategoriesModel> getCategories() async {
    return await _client.getRequest('/products/categories', converter: (json) {
      return CategoriesModel.fromJson(json);
    });
  }

  @override
  Future<ProductsModel> getProductsByCategory({required String slug}) async {
    return await _client.getRequest(
      '/products/category/$slug',
      converter: (json) => ProductsModel.fromJson(json),
    );
  }
}
