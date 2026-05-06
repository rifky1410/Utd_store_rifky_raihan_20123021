import '../domain/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  // Fungsi yang dipanggil oleh Cubit
  Future<List<ProductModel>> fetchAllProducts() async {
    final List<dynamic> data = await remoteDataSource.fetchProducts();
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}