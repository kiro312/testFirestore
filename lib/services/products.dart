import 'dart:convert';
import 'dart:io';
import 'package:first_assignment/models/product_list_item_model.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  static var client = http.Client();

  static Future<dynamic> getAllProducts() async {
    var response = await client.get(
      Uri.https(
        'first-assignment-e6e6a-default-rtdb.firebaseio.com',
        'products-list.json',
      ),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      List<ProductListItemModel> products = [];
      parsed.forEach((key, value) {
        products.add(ProductListItemModel.fromJson(key, value));
      });
      return products;
    } else {
      return [];
    }
  }

  // post product
  // static Future<dynamic> postProduct(Map<String, dynamic> body) async {
  // var response = await client.post(
  //   Uri.https(
  //     'first-assignment-e6e6a-default-rtdb.firebaseio.com',
  //     'products-list.json',
  //   ),
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: jsonEncode(body),
  // );
  // print(response.statusCode);

  // if (response.statusCode == 200) {
  //   var jsonString = response.body;
  //   return jsonDecode(jsonString);
  // } else {
  //   return [];
  // }
  // }
}
