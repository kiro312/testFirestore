// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.name, required this.id});

  factory CategoryModel.fromFireStore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return CategoryModel(
      id: document.id,
      name: document['name'] as String,
    );
  }

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}
