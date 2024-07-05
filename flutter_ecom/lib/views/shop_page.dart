import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/shop_list.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../common/common.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    ProductModel.items = [];
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        if (productsData is List) {
          ProductModel.items =
              productsData.map<Items>((item) => Items.fromMap(item)).toList();
        } else {
          debugPrint("No Data: productsData is not a List");
        }
        setState(() {});
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);

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
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(
              CupertinoIcons.bag,
              color: Colors.black87,
            ),
          )
              .badge(
                count: _cartProvider.shoppingCart.length,
                color: Colors.black12,
                size: 20,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
              .px16(),
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
        count: _cartProvider.shoppingCart.length,
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
            children: [
              if (ProductModel.items!.isNotEmpty)
                const ShopList().expand()
              else
                const CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
