// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first_assignment/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../models/product_shopping_cart_model.dart';

class ProductShoppingCartItemWidget extends StatefulWidget {
  final ProductShoppingCartModel productShoppingCartModel;

  const ProductShoppingCartItemWidget({
    super.key,
    required this.productShoppingCartModel,
  });

  @override
  State<ProductShoppingCartItemWidget> createState() =>
      _ProductShoppingCartItemWidgetState();
}

class _ProductShoppingCartItemWidgetState
    extends State<ProductShoppingCartItemWidget> {
  double total = 0;

  @override
  void initState() {
    super.initState();
    total = widget.productShoppingCartModel.price *
        widget.productShoppingCartModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 65, 65, 65),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productShoppingCartModel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: \$${widget.productShoppingCartModel.price}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  _productQuantityWidget(),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Total: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        var response = await CartService.deleteCartProduct(
                            widget.productShoppingCartModel.id);

                        Toast.show(
                          response,
                          duration: Toast.lengthLong,
                          gravity: Toast.bottom,
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productQuantityWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.white),
          onPressed: () {
            if (widget.productShoppingCartModel.quantity > 1) {
              ProductShoppingCartModel newProductShoppingCartModel =
                  ProductShoppingCartModel(
                id: widget.productShoppingCartModel.id,
                product_id: widget.productShoppingCartModel.product_id,
                name: widget.productShoppingCartModel.name,
                price: widget.productShoppingCartModel.price,
                quantity: widget.productShoppingCartModel.quantity - 1,
              );

              CartService.updateCartProductQuantity(
                  newProductShoppingCartModel);

              setState(() {
                widget.productShoppingCartModel.quantity--;
                total = widget.productShoppingCartModel.price *
                    widget.productShoppingCartModel.quantity;
              });
            } else {
              Toast.show(
                "Can't have less than 1 quantity",
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
              );
            }
          },
        ),
        Text(
          widget.productShoppingCartModel.quantity.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            ProductShoppingCartModel newProductShoppingCartModel =
                ProductShoppingCartModel(
              id: widget.productShoppingCartModel.id,
              product_id: widget.productShoppingCartModel.product_id,
              name: widget.productShoppingCartModel.name,
              price: widget.productShoppingCartModel.price,
              quantity: widget.productShoppingCartModel.quantity + 1,
            );

            await CartService.updateCartProductQuantity(
                newProductShoppingCartModel);

            setState(() {
              widget.productShoppingCartModel.quantity++;
              total = widget.productShoppingCartModel.price *
                  widget.productShoppingCartModel.quantity;
            });
          },
        ),
      ],
    );
  }
}
