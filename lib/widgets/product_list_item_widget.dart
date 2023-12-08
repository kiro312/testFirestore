import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:first_assignment/models/product_list_item_model.dart';
import 'package:first_assignment/models/product_shopping_cart_model.dart';
import 'package:first_assignment/services/cart.dart';

import '../pages/shopping_cart_page.dart';

class ProductListItemWidget extends StatelessWidget {
  final ProductListItemModel productListItemModel;

  const ProductListItemWidget({
    Key? key,
    required this.productListItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Card(
      child: ListTile(
        tileColor: const Color.fromARGB(255, 65, 65, 65),
        textColor: Colors.white,
        leading: Image.network(
          productListItemModel.image,
          width: 50,
          height: 50,
        ),
        title: Text(
          productListItemModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Price: ${productListItemModel.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
          onPressed: () async {
            ProductShoppingCartModel productShoppingCartModel =
                ProductShoppingCartModel(
              id: '',
              product_id: productListItemModel.id,
              name: productListItemModel.name,
              price: productListItemModel.price,
              quantity: 1,
            );

            var response =
                await CartService.addProductToCart(productShoppingCartModel);

            Toast.show(
              response,
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );

            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
