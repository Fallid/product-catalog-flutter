import 'package:dio/dio.dart';
import 'package:product_catalog/core/domain/product.dart';
import 'package:product_catalog/core/network/api_endpoints.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio);
  Future<List<Product>> getProducts() async {
    try {
      final resp = await _dio.get(ApiEndpoints.products);

      if (resp.statusCode == 200) {
        final List<dynamic> jsonList = resp.data;

        return jsonList.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      } else {
        throw Exception('Failed to fetch products: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final resp = await _dio.get(ApiEndpoints.productDetail(id));

      if (resp.statusCode == 200) {
        return Product.fromJson(resp.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load product detail');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      } else {
        throw Exception('Failed to fetch products: ${e.message}');
      }
    }
    catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final allProducts = await getProducts();
      
      if (query.isEmpty) {
        return allProducts;
      }
      
      return allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
