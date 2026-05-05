import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../../../../core/di/injection.dart';
import '../../../bookmark/data/isar_service.dart';
import '../../../bookmark/domain/bookmark_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTD Store Kelompok 9'),
        actions: [
          // TOMBOL MENUJU HALAMAN CRYPTO (WebSocket)
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () => context.push('/crypto'), 
          ),
          // TOMBOL MENUJU HALAMAN BOOKMARK (Isar Database)
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.push('/bookmark'), 
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          } else if (state is ProductLoaded) {
            final products = state.products;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('\$${item.price}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.teal),
                      onPressed: () async {
                        final isarService = locator<IsarService>();
                        final now = DateTime.now();
                        
                        final newBookmark = Bookmark()
                          ..productId = item.id
                          ..name = item.name
                          ..image = item.image
                          ..price = item.price
                          ..timestamp = now;

                        await isarService.saveBookmark(newBookmark);

                        final jam = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tersimpan di Bookmark pada $jam!'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.teal.shade800,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}