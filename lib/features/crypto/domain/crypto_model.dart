class CryptoModel {
  final String symbol;
  final String price;

  CryptoModel({required this.symbol, required this.price});

  // Mengubah data JSON dari WebSocket menjadi object CryptoModel
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      symbol: json['s'] ?? '',
      price: json['p'] ?? '0.00',
    );
  }
}