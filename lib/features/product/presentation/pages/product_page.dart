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
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "UTD Store",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "Rifky Raihan", // Identitas NPM 20123021
              style: TextStyle(fontSize: 14, color: Colors.tealAccent),
            ),
          ],
        ),
        actions: [
          // Tombol Ikon HP: Menuju Integrasi Native Android
          IconButton(
            icon: const Icon(Icons.phonelink_setup, color: Colors.white),
            onPressed: () {
              // Memanggil route /native sesuai AppRouter
              context.push('/native'); 
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.indigoAccent),
            onPressed: () => context.push('/bookmark'),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.tealAccent));
          } else if (state is ProductLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final item = state.products[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item.name, // Logika "[Diskon 10%]" otomatis dari Repo[cite: 1]
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "\$${item.price}",
                      style: const TextStyle(color: Colors.tealAccent),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.pinkAccent),
                      onPressed: () async {
                        final isarService = locator<IsarService>();
                        final newBookmark = Bookmark()
                          ..productId = item.id.toString()
                          ..name = item.name
                          ..image = item.image
                          ..price = double.tryParse(item.price) ?? 0.0
                          ..timestamp = DateTime.now(); // Timestamp Isar[cite: 1]

                        await isarService.saveBookmark(newBookmark);
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tersimpan di Bookmark!')),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }
          return const Center(child: Text('Tidak ada data.'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/crypto'), // Route ke Crypto[cite: 1]
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.show_chart, color: Colors.black),
        label: const Text("Live Crypto", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}