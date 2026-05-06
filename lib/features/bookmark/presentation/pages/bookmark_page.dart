import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../data/isar_service.dart';
import '../../domain/bookmark_model.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isarService = locator<IsarService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Bookmark'),
        backgroundColor: Colors.tealAccent.shade100,
      ),
      body: StreamBuilder<List<Bookmark>>(
        stream: isarService.listenToBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final bookmarks = snapshot.data ?? [];
          
          if (bookmarks.isEmpty) {
            return const Center(child: Text('Belum ada produk yang disimpan.'));
          }

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final item = bookmarks[index];
              return ListTile(
                // Menghapus null-aware (?? '') karena field sudah non-nullable
                leading: Image.network(item.image, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.broken_image)),
                title: Text(item.name),
                subtitle: Text('\$${item.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => isarService.deleteBookmark(item.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}