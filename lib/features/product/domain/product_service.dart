import '../data/product_repository.dart';
import 'product_model.dart';

class ProductService {
  final ProductRepository repository;

  ProductService(this.repository);

  Future<List<Product>> fetchProducts() async {
    final products = await repository.getAllProducts();

    // LOGIKA PERSONAL: NIM Ganjil (20123021) -> Tambah [Diskon 10%]
    final manipulatedProducts = products.map((product) {
      return product.copyWith(name: '${product.name} [Diskon 10%]');
    }).toList();

    return manipulatedProducts;
  }
}