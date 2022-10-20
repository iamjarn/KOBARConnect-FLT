import 'package:kobar/UI/Models/Place.dart';

class Category {
  int id;
  String name;
  bool is_enable_ticket;
  List<Place> list_tour = [];

  Category(
      {required this.id,
      required this.name,
      required this.list_tour,
      required this.is_enable_ticket});
}
