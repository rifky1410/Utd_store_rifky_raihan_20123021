import 'package:isar/isar.dart';
part 'bookmark_model.g.dart'; // File ini akan terbuat otomatis nanti

@collection
class Bookmark {
  Id id = Isar.autoIncrement;
  late String productId;
  late String name;
  late String image;
  late double price;
  late DateTime timestamp; // Wajib untuk modul: Format Tanggal/Waktu
}