import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../domain/crypto_model.dart';

class CryptoService {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'),
  );

  Stream<CryptoModel> get cryptoStream {
    return _channel.stream.map((data) {
      final Map<String, dynamic> decodedData = jsonDecode(data);
      return CryptoModel.fromJson(decodedData);
    });
  }

  // Fungsi untuk menutup koneksi (Solusi Error)
  void closeConnection() {
    _channel.sink.close();
  }
}