class ProductModel {
  final int id;
  final String name;
  final String image;
  final String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      image: json['image'],
      price: json['price'].toString(),
    );
  }
}