import 'package:first_assignment/models/product_shopping_cart_model.dart';
import 'package:first_assignment/services/cart.dart';
import 'package:first_assignment/services/firestore_test.dart';
import 'package:first_assignment/widgets/product_shopping_cart_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<ProductShoppingCartModel> list = [];

  Future getCartProducts() async {
    List<ProductShoppingCartModel> response =
        await CartService.getCartProducts();
    list = response;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCartProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCartProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ElevatedButton(
            onPressed: () async {
              await FirestoreService.test();
            },
            child: const Text("test"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  SafeArea _buildUI() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 65, 65, 65),
          title: const Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // ProductShoppingCartItemWidget(
                      //   productShoppingCartModel: list[index],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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
