import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kobar/UI/Models/Category.dart';
import 'package:kobar/UI/Models/Header.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Models/Transaction.dart';
import 'package:kobar/Utility/constant.dart';

class ContentService {
  static Future<List<Header>> getContent() async {
    String url = "${API_URL}api/contents";
    var result = await http.get(Uri.parse(url));
    var jsonObject = json.decode(result.body) as List;

    return jsonObject
        .map<Header>((item) => Header(
            header_type: item["file_type"],
            value: item["full_path"],
            type: "network",
            description: item["message"]))
        .toList();
  }

  static Future<List<Category>> getRecommend() async {
    String url = "${API_URL}api/recommends";
    var result = await http.get(Uri.parse(url));
    var jsonObject = json.decode(result.body) as List;

    return jsonObject.map<Category>((item) {
      var list_tour = item["recommends"].map<Place>((place) {
        Category category = Category(
            is_enable_ticket: place["category"]["is_enable_ticket"],
            id: place["category"]["id"],
            name: place["category"]["name"],
            list_tour: []);

        return Place(
          id: place["id"],
          name: place["name"],
          description: place["description"],
          image: place["generated_images"].length > 0
              ? place["generated_images"][0]
              : null,
          images: place["generated_images"],
          longitude: place["longitude"],
          latitude: place["latitude"],
          whatsapp: place["whatsapp"],
          phone: place["phone"],
          store_url: place["store_url"],
          website: place["website"],
          instagram: place["instagram"],
          kid_prices: place["kid_prices"],
          adult_prices: place["adult_prices"],
          transport_prices: place["transport_prices"],
          address: place["address"],
          operational_days: place["operational_days"],
          category: category,
        );
      }).toList();

      return Category(
          is_enable_ticket: item["is_enable_ticket"],
          id: item["id"],
          name: item["name"],
          list_tour: list_tour);
    }).toList();
  }

  static Future<List<Category>> getCategories() async {
    String url = "${API_URL}api/categories";
    var result = await http.get(Uri.parse(url));
    var jsonObject = json.decode(result.body) as List;

    List<Category> baru = [];
    baru.add(
        Category(is_enable_ticket: false, id: 0, name: "Semua", list_tour: []));
    jsonObject
        .map((item) => baru.add(Category(
            is_enable_ticket: item["is_enable_ticket"],
            id: item["id"],
            name: item["name"],
            list_tour: [])))
        .toList();

    return baru;
  }

  static Future<List<Place>> getTours(int id_category, String? keyword) async {
    String url = "${API_URL}api/tours";
    if (id_category != 0) {
      url += "?category=" + id_category.toString();
    }
    if (keyword != null) {
      if (id_category != 0) {
        url += "&keyword=" + keyword;
      } else {
        url += "?keyword=" + keyword;
      }
    }
    var result = await http.get(Uri.parse(url));
    var jsonObject = json.decode(result.body);

    var data = jsonObject["data"] as List;
    List<Place> list_tour = data.map((e) {
      Category category = Category(
          is_enable_ticket: e["category"]["is_enable_ticket"],
          id: e["category"]["id"],
          name: e["category"]["name"],
          list_tour: []);

      return Place(
        id: e["id"],
        name: e["name"],
        description: e["description"],
        image:
            e["generated_images"].length > 0 ? e["generated_images"][0] : null,
        longitude: e["longitude"],
        latitude: e["latitude"],
        images: e["generated_images"],
        whatsapp: e["whatsapp"],
        phone: e["phone"],
        store_url: e["store_url"],
        website: e["website"],
        instagram: e["instagram"],
        kid_prices: e["kid_prices"],
        adult_prices: e["adult_prices"],
        transport_prices: e["transport_prices"],
        address: e["address"],
        operational_days: e["operational_days"],
        category: category,
      );
    }).toList();

    return list_tour;
  }

  static Future<Map<String, dynamic>> createOrder(
      Transaction data, int id) async {
    Uri url = Uri.parse("${API_URL}api/tour/$id/transaction");

    var map = new Map<String, dynamic>();
    map['visit_date'] = data.visit_date;
    map['adult_quantity'] = data.adult_quantity;
    map['child_quantity'] = data.child_quantity;
    map['is_use_transport'] = data.is_use_transport;
    map['name'] = data.name;
    map['identity_number'] = data.identity_number;
    map['email'] = data.email;
    map['phone_number'] = data.phone_number;
    map['address'] = data.address;

    var response = await http.post(url, body: map);
    var body_response = json.decode(response.body);

    Map<String, dynamic> payload = {};
    payload["status"] = body_response["status"];
    payload["code"] = response.statusCode;
    payload["data"] = body_response["data"];

    return payload;
  }
}
