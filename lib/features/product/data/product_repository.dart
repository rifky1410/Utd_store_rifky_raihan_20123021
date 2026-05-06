import '../domain/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  Future<List<ProductModel>> fetchAllProducts() async {
    // Ambil data mentah dari remote data source
    final List<dynamic> data = await remoteDataSource.fetchProducts();

    // Logika Personal (Anti-AI): Manipulasi data di level Repository[cite: 1].
    // Digit terakhir NIM 20123021 adalah 1 (Ganjil).
    // Aturan: Tambahkan "[Diskon 10%]" di belakang semua nama produk[cite: 1].
    return data.map((json) {
      final product = ProductModel.fromJson(json);
      
      // Menggunakan copyWith untuk mengubah nama produk secara aman
      return ProductModel(
        id: product.id,
        name: "${product.name} [Diskon 10%]", // Penambahan teks diskon
        price: product.price,
        image: product.image,
      );
    }).toList();
  }
}