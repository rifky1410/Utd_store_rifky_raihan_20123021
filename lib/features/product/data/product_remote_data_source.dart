import 'package:dio/dio.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  // Fungsi untuk mengambil data produk dari API untuk UTS Kelompok 9
  Future<List<dynamic>> fetchProducts() async {
    try {
      // Menggunakan API Dummy untuk keperluan UTS
      final response = await dio.get('https://fakestoreapi.com/products');
      
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Gagal memuat data produk');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}