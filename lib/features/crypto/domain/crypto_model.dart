import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../domain/crypto_model.dart';

class CryptoService {
  late WebSocketChannel _channel;

  CryptoService() {
    // Membuka jalur komunikasi real-time ke server Binance khusus Bitcoin
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'),
    );
  }

  // Stream ibarat air yang mengalir terus menerus ke UI
  Stream<CryptoModel> get cryptoStream {
    return _channel.stream.map((event) {
      final json = jsonDecode(event);
      return CryptoModel.fromJson(json);
    });
  }

  // Wajib ditutup saat halaman ditinggalkan agar tidak bocor memori
  void dispose() {
    _channel.sink.close();
  }
}