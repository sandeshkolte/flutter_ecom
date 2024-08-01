import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/provider/product_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/shop_list.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Icon(
          Icons.cruelty_free_rounded,
          color: Vx.amber300,
          size: 28,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              productProvider.fetchProduct();
            },
          ),
        ],
        shadowColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            context.theme.floatingActionButtonTheme.backgroundColor,
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        child: const Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
      ).badge(
        count: cartProvider.shoppingCart.length,
        color: Colors.blueGrey,
        size: 20,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const ShopList().expand()],
          ),
        ),
      ),
    );
  }
}
