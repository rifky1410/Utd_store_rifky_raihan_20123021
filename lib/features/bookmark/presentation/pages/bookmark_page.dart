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
      appBar: AppBar(title: const Text('My Bookmarks')),
      // Menggunakan StreamBuilder agar reaktif (watch)
      body: StreamBuilder<List<Bookmark>>(
        stream: isarService.listenToBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada bookmark"));
          }

          final bookmarks = snapshot.data!;
          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final item = bookmarks[index];
              
              // Logika Personal: Format jam HH:mm
              final String formattedTime = 
                  "${item.timestamp.hour.toString().padLeft(2, '0')}:${item.timestamp.minute.toString().padLeft(2, '0')}";

              return ListTile(
                leading: Image.network(item.image, width: 50),
                title: Text(item.name),
                // Aturan ETS: Tampilkan teks "Disimpan pada ..."
                subtitle: Text("Disimpan pada $formattedTime"), 
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