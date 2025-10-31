import 'package:hive/hive.dart';

class CartItem extends HiveObject {
  final String title;
  final double price;
  final String image;

  CartItem({
    required this.title,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      image: map['image'] as String,
    );
  }
}
