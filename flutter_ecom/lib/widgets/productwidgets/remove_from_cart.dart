import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../models/product_model.dart';

class RemoveFromCart extends StatelessWidget {
  final Items product;
  const RemoveFromCart({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // VxState.watch(context, on: [AddMutation, RemoveMutation]);
    // final CartModel _cart = (VxState.store as MyStore).cart;
    // bool isInCart = _cart.items.contains(catalog);
    return Consumer<CartProvider>(builder: (context, value, child) {
      // final CartModel _cart = Provider.of(context);

      return ElevatedButton(
          onPressed: () => value.removeFromCart(product.id),
          // onPressed: () {
          //   debugPrint(isInCart.toString());

          //   if (!isInCart) {
          //     value.addToCart(product);
          //   }
          // },
          style: const ButtonStyle(
              shape: WidgetStatePropertyAll(StadiumBorder()),
              backgroundColor: WidgetStatePropertyAll(Colors.white)),
          child: "remove".text.black.make());
    });
  }
}
