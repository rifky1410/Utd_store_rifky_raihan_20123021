import 'package:dio/dio.dart';
import '../domain/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    return (response.data as List).map((x) => ProductModel.fromJson(x)).toList();
  }
}