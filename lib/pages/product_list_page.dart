// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first_assignment/models/product_list_item_model.dart';
import 'package:first_assignment/pages/shopping_cart_page.dart';
import 'package:first_assignment/services/firestore_test.dart';
import 'package:first_assignment/services/products.dart';
import 'package:first_assignment/widgets/product_list_item_widget.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late List<ProductListItemModel> list = <ProductListItemModel>[];

  Future getAllProducts() async {
    var response = await ProductsService.getAllProducts();
    list = response;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: getAllProducts(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return _buildUI();
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await FirestoreService.test();
            },
            child: const Text("test alo"),
          )
        ],
      ),
    );
  }

  SafeArea _buildUI() {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 47, 47, 47),
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 65, 65, 65),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Product List',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  // go to shopping cart page
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 65, 65, 65),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShoppingCartPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ProductListItemWidget(
                    productListItemModel: list[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
