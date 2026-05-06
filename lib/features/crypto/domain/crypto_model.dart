class CryptoModel {
  final String price;
  CryptoModel({required this.price});

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    // 'p' adalah key untuk harga di WebSocket Binance
    return CryptoModel(price: json['p'] ?? "0.0");
  }
}