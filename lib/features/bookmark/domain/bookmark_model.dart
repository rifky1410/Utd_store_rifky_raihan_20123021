import 'package:isar/isar.dart';

part 'bookmark_model.g.dart';

@collection
class Bookmark {
  Id id = Isar.autoIncrement; 
  late String productId;
  late String name;
  late String image;
  late double price;
  
  // LOGIKA PERSONAL: Menyimpan waktu saat tombol ditekan
  late DateTime timestamp; 
}