import 'product_model.dart';
import '../data/product_repository.dart';

class ProductService {
  final ProductRepository repository;

  ProductService(this.repository);

  // Pastikan menggunakan ProductModel (bukan Product)
  Future<List<ProductModel>> getAllProducts() async {
    // Memanggil fungsi fetchAllProducts yang sudah kita buat di Repository tadi
    return await repository.fetchAllProducts();
  }
}