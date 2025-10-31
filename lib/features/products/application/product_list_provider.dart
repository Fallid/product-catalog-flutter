import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog/core/domain/product.dart';
import 'package:product_catalog/core/network/dio_client.dart';
import 'package:product_catalog/core/services/product_service.dart';
import 'package:product_catalog/features/products/repostiory/product_repository.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductService(dio);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final service = ref.watch(productServiceProvider);
  return ProductRepository(service);
});

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getProducts();
});

final productDetailProvider = FutureProvider.family<Product, int>((ref, id) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getProductById(id);
});

final productSearchProvider = FutureProvider.family<List<Product>, String>((ref, query) async {
  final repo = ref.watch(productRepositoryProvider);
  return repo.searchProducts(query);
});