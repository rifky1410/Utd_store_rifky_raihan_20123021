class ProductModel {
  final int id;
  final String name;
  final String price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'price': price,
      'image': image,
    };
  }

  // Menambahkan copyWith untuk mendukung product_service
  ProductModel copyWith({
    int? id,
    String? name,
    String? price,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}