import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../domain/crypto_model.dart';

class CryptoService {
  // Koneksi WebSocket ke Binance untuk harga Bitcoin
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade')
  );

  Stream<CryptoModel> get cryptoStream => _channel.stream.map(
    (event) => CryptoModel.fromJson(jsonDecode(event))
  );

  void closeConnection() {
    _channel.sink.close();
  }
}