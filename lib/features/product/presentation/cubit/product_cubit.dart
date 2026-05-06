import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    try {
      emit(ProductLoading());
      // Memanggil fungsi yang ada di ProductRepository
      final products = await repository.fetchAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}