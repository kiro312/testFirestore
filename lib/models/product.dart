// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_assignment/models/category.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final CategoryModel category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category_id': category.id,
    };
  }

  factory Product.fromFireStore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
    List<CategoryModel> categories,
  ) {
    String categoryId = document['category_id'];

    CategoryModel category = categories.firstWhere(
      (element) => element.id == categoryId,
      orElse: () => CategoryModel(id: '', name: 'Unknown Category'),
    );

    return Product(
      id: document.id,
      name: document['name'],
      price: document['price'],
      category: category,
    );
  }

  @override
  String toString() =>
      'Product(id: $id, name: $name, price: $price, category: ${category.toString()})';
}
