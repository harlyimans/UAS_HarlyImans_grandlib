import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print("========== PRODUCT JSON ==========");
    print(json);
    print("id        : ${json['id']}");
    print("name      : ${json['name']}");
    print("price     : ${json['price']}");
    print("image_url : ${json['image_url']}");
    print("category  : ${json['category']}");
    print("==================================");

    return ProductModel(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}
