// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  List<Product> products;
  int total;
  int skip;
  int limit;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  String? id;
  String title;
  String description;
  String price;
  String discountPercentage;
  String rating;
  String stock;
  String brand;
  Category category;
  String thumbnail;
  List<String> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"].toString(),
    title: json["title"],
    description: json["description"],
    price: json["price"].toString(),
    discountPercentage: json["discountPercentage"]?.toDouble().toString()??"",
    rating: json["rating"]?.toDouble().toString()??"",
    stock: json["stock"].toString(),
    brand: json["brand"].toString(),
    category: categoryValues.map[json["category"]]!,
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": categoryValues.reverse[category],
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

enum Category { LAPTOPS, FRAGRANCES }

final categoryValues = EnumValues({
  "fragrances": Category.FRAGRANCES,
  "laptops": Category.LAPTOPS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
