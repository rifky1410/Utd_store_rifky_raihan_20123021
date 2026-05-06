import '../domain/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepository(this.remoteDataSource);

  // Nama fungsi diubah menjadi fetchAllProducts agar dikenali oleh product_service.dart
  Future<List<ProductModel>> fetchAllProducts() async {
    final products = await remoteDataSource.getProducts();
    
    // Logika Modul: Menambahkan "[Diskon 10%]" tetap dipertahankan
    return products.map((item) {
      return ProductModel(
        id: item.id,
        name: "${item.name} [Diskon 10%]",
        image: item.image,
        price: item.price,
      );
    }).toList();
  }
}