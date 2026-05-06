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
    return BlocProvider(
      create: (_) => locator<ProductCubit>()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1A2E),
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("UTD Store", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Text("Purnama Raharja - Kelompok 9", style: TextStyle(fontSize: 14, color: Colors.tealAccent)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.phonelink_setup, color: Colors.white),
              onPressed: () => context.push('/native'),
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
                    decoration: BoxDecoration(color: const Color(0xFF16213E), borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Image.network(item.image, width: 50),
                      title: Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("\$${item.price}", style: const TextStyle(color: Colors.tealAccent)),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_border, color: Colors.pinkAccent),
                        onPressed: () async {
                          final isar = locator<IsarService>();
                          final book = Bookmark()
                            ..productId = item.id.toString()
                            ..name = item.name
                            ..image = item.image
                            ..price = double.tryParse(item.price) ?? 0.0
                            ..timestamp = DateTime.now();
                          await isar.saveBookmark(book);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Bookmark!")));
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Gagal memuat data", style: TextStyle(color: Colors.white)));
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/crypto'),
          backgroundColor: Colors.orangeAccent,
          icon: const Icon(Icons.show_chart, color: Colors.black),
          label: const Text("Live Crypto", style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}