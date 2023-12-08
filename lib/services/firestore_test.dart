// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_assignment/models/category.dart';
import 'package:first_assignment/models/product.dart';
import 'package:first_assignment/services/collections_config.dart';

class FirestoreService {
  static var db = FirebaseFirestore.instance;

  // static Future<List<CategoryModel>> getAllCategories() async {
  //   List<CategoryModel> list = [];

  //   await db.collection("categories").get().then((event) {
  //     for (var doc in event.docs) {
  //       list.add(CategoryModel.fromFireStore(doc));
  //     }
  //   });

  //   // for (var i = 0; i < list.length; i++) {
  //   //   print(list[i].toString());
  //   // }
  //   return list;
  // }

  // static Future testGetAll() async {
  //   List<Product> list = [];

  //   await db.collection("products").get().then((event) {
  //     for (var doc in event.docs) {
  //       list.add(Product.fromFireStore(doc));
  //     }
  //   });

  //   for (var i = 0; i < list.length; i++) {
  //     print(list[i].toString());
  //   }
  // }

  static Future testGetOne(Product p) async {
    // await db.collection("asd").doc(p.id).get();

    await db.collection("products").where("price", isEqualTo: 100).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  static Future testSet(Product product) async {
    await db
        .collection("products")
        .doc()
        .set(product.toMap())
        .then((value) => print("Done"))
        .onError((e, _) => print("Error writing document: $e"));
  }

  static Future testsUpdate(Product product) async {
    // Map<String, dynamic> data = {
    //   "name": "updated kito",
    //   "price": 100,
    // };

    await db.collection("products").doc(product.id).update(
      {
        "name": "updated kito",
      },
    );
  }

  static Future testsDelete() async {
    await db
        .collection("products")
        .doc("kiro_krio")
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        )
        .onError(
            (error, stackTrace) => print("Error deleting document: $error"));
  }

  static Future test() async {
    List<CategoryModel> categories = await getAllCategories();

    List<Product> products = await getAllProducts(categories);
    print('Products: ');
    for (var product in products) {
      print(product.toString());
    }
  }

  // retun a list of categories
  static Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> list = [];
    await db.collection("categories").get().then((event) {
      for (var doc in event.docs) {
        list.add(CategoryModel.fromFireStore(doc));
      }
    });
    return list;
  }

  // return a list of products
  static Future<List<Product>> getAllProducts(
      List<CategoryModel> categoriesList) async {
    List<Product> list = [];

    await db.collection("products").get().then((event) {

      for (var doc in event.docs) {
        list.add(Product.fromFireStore(doc, categoriesList));
      }
      
    });
    return list;
  }
}
