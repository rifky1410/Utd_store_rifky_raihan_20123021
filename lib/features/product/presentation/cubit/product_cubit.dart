import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    try {
      emit(ProductLoading()); // Mengubah state ke loading
      
      // Mengambil data dari repository yang terhubung ke API
      final products = await repository.fetchAllProducts();
      
      if (products.isEmpty) {
        emit(ProductError("Data produk tidak ditemukan di server."));
      } else {
        emit(ProductLoaded(products)); // Mengirim data ke UI
      }
    } catch (e) {
      emit(ProductError("Terjadi kesalahan: ${e.toString()}"));
    }
  }
}