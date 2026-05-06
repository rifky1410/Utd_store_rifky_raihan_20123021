import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';
import '../../data/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      // Memanggil fungsi fetchAllProducts yang baru saja di-update di Repository
      final products = await repository.fetchAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Gagal mengambil data: ${e.toString()}"));
    }
  }
}