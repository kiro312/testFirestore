import 'dart:convert';
import 'dart:io';
import 'package:first_assignment/models/product_shopping_cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class CartService {
  static var client = http.Client();

  FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<dynamic> addProductToCart(
      ProductShoppingCartModel product) async {
    var response = await client.post(
      Uri.https(
        'first-assignment-e6e6a-default-rtdb.firebaseio.com',
        'cart-list.json',
      ),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return "Product added successfully";
    } else {
      return "Error adding product";
    }
  }

  static Future<dynamic> getCartProducts() async {
    var response = await client.get(
      Uri.https(
        'first-assignment-e6e6a-default-rtdb.firebaseio.com',
        'cart-list.json',
      ),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      List<ProductShoppingCartModel> products = [];
      parsed.forEach((key, value) {
        products.add(ProductShoppingCartModel.fromJson(key, value));
      });
      return products;
    } else {
      return [];
    }
  }

  static Future<dynamic> updateCartProductQuantity(
      ProductShoppingCartModel product) async {

    DatabaseReference ref = FirebaseDatabase.instance.ref("cart-list");
    ref.child(product.id).update({
      "quantity": product.quantity,
    });
    
  }

  // make delete request
  static Future<dynamic> deleteCartProduct(String id) async {
    var response = await client.delete(
      Uri.https(
        'first-assignment-e6e6a-default-rtdb.firebaseio.com',
        'cart-list/$id.json',
      ),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      return "Product deleted successfully";
    } else {
      return "Error deleting product";
    }
  }
}
