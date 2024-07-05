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
    // VxState.watch(context, on: [AddMutation, RemoveMutation]);
    // final CartModel _cart = (VxState.store as MyStore).cart;
    // bool isInCart = _cart.items.contains(catalog);
    return Consumer<CartProvider>(builder: (context, value, child) {
      // final CartModel _cart = Provider.of(context);

      var isInCart = value.shoppingCart.where((elem) => elem.id == product.id);

      return ElevatedButton(
          onPressed: () {
            if(product.stock<=0) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "${product.name} Out of Stock",
                  ),backgroundColor: Vx.rose500,));
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
          style: ButtonStyle(
              shape: const WidgetStatePropertyAll(StadiumBorder()),
              backgroundColor:
                  context.theme.textButtonTheme.style?.backgroundColor),
          child: isInCart.isNotEmpty
              ? const Icon(Icons.done)
              : Row(
                  children: [
                    // const Icon(Icons.add,color: Colors.white,),
                    "cart".text.white.make(),
                  ],
                ));
    });
  }
}
