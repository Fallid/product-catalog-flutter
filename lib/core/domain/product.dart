import 'package:product_catalog/core/domain/rating.dart';

class Products {
    int id;
    String title;
    double price;
    String description;
    String category;
    String image;
    Rating rating;

    Products({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

}
