import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../bookmark/data/isar_service.dart';
import '../../../bookmark/domain/bookmark_model.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTD Store - Kelompok 9'),
        backgroundColor: Colors.tealAccent.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.push('/bookmark'),
          ),
          IconButton(
            icon: const Icon(Icons.currency_bitcoin),
            onPressed: () => context.push('/crypto'),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final item = state.products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      item.image,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('\$${item.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.teal),
                      onPressed: () async {
                        final isarService = locator<IsarService>();
                        
                        // PERBAIKAN: Tambahkan .toString() pada item.id
                        final newBookmark = Bookmark()
                          ..productId = item.id.toString() 
                          ..name = item.name
                          ..image = item.image
                          ..price = double.tryParse(item.price) ?? 0.0 
                          ..timestamp = DateTime.now();

                        await isarService.saveBookmark(newBookmark);
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil disimpan ke Bookmark!'),
                              backgroundColor: Colors.teal,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Tidak ada data produk.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ProductCubit>().fetchAllProducts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}