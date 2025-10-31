import 'package:product_catalog/core/domain/product.dart';
import 'package:product_catalog/core/services/product_service.dart';

class ProductRepository {
  final ProductService _productService;
  ProductRepository(this._productService);

  Future<List<Product>> getProducts() async {
    try {
      return await _productService.getProducts();
    } catch (e) {
      throw Exception('Failed to load product from repository: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      return await _productService.getProductById(id);
    } catch (e) {
      throw Exception('Failed to load product detail from repository: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      return await _productService.searchProducts(query);
    } catch (e) {
      throw Exception('Failed to search products from repository: $e');
    }
  }
}