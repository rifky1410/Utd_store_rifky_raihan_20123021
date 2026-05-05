class Product {
  final String id;
  final String name;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? 'Tanpa Nama',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Product copyWith({String? name}) {
    return Product(
      id: this.id,
      name: name ?? this.name,
      image: this.image,
      price: this.price,
    );
  }
}