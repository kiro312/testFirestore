// ignore_for_file: non_constant_identifier_names

class ProductShoppingCartModel {
  final String id;
  final String product_id;
  final String name;
  final double price;
  late int quantity;

  ProductShoppingCartModel({
    required this.id,
    required this.product_id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory ProductShoppingCartModel.fromJson(String key, Map<String, dynamic> json) {
    return ProductShoppingCartModel(
      id: key,
      product_id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
