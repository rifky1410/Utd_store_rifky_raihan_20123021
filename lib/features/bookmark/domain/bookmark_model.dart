import 'package:isar/isar.dart';

part 'bookmark_model.g.dart';

@collection
class Bookmark {
  Id id = Isar.autoIncrement;

  late String productId;
  late String name;
  late String image;
  late double price;
  late DateTime timestamp; // Wajib untuk mencatat waktu simpan
}