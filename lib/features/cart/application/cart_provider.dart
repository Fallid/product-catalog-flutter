import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog/core/domain/cart_item.dart';
import 'package:product_catalog/core/services/cart_service.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService();
});

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final cartService = ref.watch(cartServiceProvider);
  return cartService.getAllCartItems();
});

final cartCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartItemsProvider);
  return items.length;
});
