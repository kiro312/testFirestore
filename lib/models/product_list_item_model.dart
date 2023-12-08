class ProductListItemModel {
  final String id;
  final String image;
  final String name;
  final double price;

  ProductListItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  // fromJson
  factory ProductListItemModel.fromJson(String key, Map<String, dynamic> json) {
    return ProductListItemModel(
      id: key,
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}
