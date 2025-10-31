import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_catalog/core/domain/cart_item.dart';

class CartService {
  static const String _cartBoxName = 'cart';
  Box<Map>? _cartBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _cartBox = await Hive.openBox<Map>(_cartBoxName);
  }

  Box<Map> get cartBox {
    if (_cartBox == null || !_cartBox!.isOpen) {
      throw Exception('Cart box is not initialized. Call init() first.');
    }
    return _cartBox!;
  }

  Future<void> addToCart(CartItem item) async {
    final box = cartBox;
    await box.put(item.title, item.toMap());
  }

  List<CartItem> getAllCartItems() {
    final box = cartBox;
    return box.values
        .map((mapData) => CartItem.fromMap(Map<String, dynamic>.from(mapData)))
        .toList();
  }

  CartItem? getCartItem(String title) {
    final box = cartBox;
    final mapData = box.get(title);
    if (mapData == null) return null;
    return CartItem.fromMap(Map<String, dynamic>.from(mapData));
  }

  Future<void> removeFromCart(String title) async {
    final box = cartBox;
    await box.delete(title);
  }

  bool isInCart(String title) {
    final box = cartBox;
    return box.containsKey(title);
  }

  int getCartCount() {
    final box = cartBox;
    return box.length;
  }

  Future<void> clearCart() async {
    final box = cartBox;
    await box.clear();
  }

  Future<void> close() async {
    await _cartBox?.close();
  }
}
