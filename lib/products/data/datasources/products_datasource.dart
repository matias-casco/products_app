import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/products/data/models/categories/category_model.dart';
import 'package:products_app/products/data/models/products/products_model.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getProducts();
  Future<List<CategoryModel>> getCategories();
}

class ProductsDatasourceImpl implements ProductsDatasource {
  ProductsDatasourceImpl({required HttpClientInterface client})
      : _client = client;

  final HttpClientInterface _client;

  @override
  Future<ProductsModel> getProducts() async {
    return await _client.getRequest<ProductsModel>(
      '/products?limit=12',
      converter: (json) => ProductsModel.fromJson(json),
    );
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await _client.getRequest<List<CategoryModel>>(
      '/products/categories',
      converter: (json) {
        final List<CategoryModel> categories = [];
        for (final item in json) {
          categories.add(CategoryModel.fromJson(item));
        }
        return categories;
      }
    );
  }
}
