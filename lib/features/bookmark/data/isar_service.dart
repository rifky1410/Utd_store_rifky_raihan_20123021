import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/bookmark_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([BookmarkSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveBookmark(Bookmark newBookmark) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.bookmarks.putSync(newBookmark));
  }

  Stream<List<Bookmark>> listenToBookmarks() async* {
    final isar = await db;
    yield* isar.bookmarks.where().watch(fireImmediately: true);
  }

  Future<void> deleteBookmark(int id) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.bookmarks.deleteSync(id));
  }
}