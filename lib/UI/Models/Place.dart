import 'package:kobar/UI/Models/Category.dart';

class Place {
  int id;
  String? name;
  String? description;
  String? image;
  List images;
  String? longitude;
  String? latitude;
  String? whatsapp;
  String? phone;
  String? store_url;
  String? website;
  String? instagram;
  int kid_prices, adult_prices, transport_prices;
  String? address, operational_days;
  Category category;

  Place(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.longitude,
      required this.latitude,
      required this.images,
      this.whatsapp,
      this.phone,
      this.store_url,
      this.website,
      this.instagram,
      required this.kid_prices,
      required this.adult_prices,
      required this.transport_prices,
      this.address,
      this.operational_days,
      required this.category});
}
