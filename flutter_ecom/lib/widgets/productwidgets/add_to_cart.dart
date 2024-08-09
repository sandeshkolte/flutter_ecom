import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/product_model.dart';

class AddToCart extends StatelessWidget {
  final Items product;
  const AddToCart({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      var isInCart = value.shoppingCart.where((elem) => elem.id == product.id);

      return ElevatedButton(
          onPressed: () {
            if (product.stock <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${product.name} Out of Stock",
                ),
                backgroundColor: Vx.rose500,
              ));
              return;
            }

            if (isInCart.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${product.name} added to cart",
                ),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Vx.emerald500,
              ));
              value.addToCart(product);
            }
          },
          style: const ButtonStyle(
              shape: WidgetStatePropertyAll(StadiumBorder()),
              backgroundColor: WidgetStatePropertyAll(Vx.sky50)),
          child: isInCart.isNotEmpty
              ? const Icon(Icons.done).centered()
              : "cart".text.color(Vx.indigo700).makeCentered());
    });
  }
}
