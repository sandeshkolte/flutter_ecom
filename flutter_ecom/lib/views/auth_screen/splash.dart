import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../common/common.dart';
import '../../models/product_model.dart';
import 'splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
     CartModel.products = [];
    getCart();
  }

  
  Future<void> getCart() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        if (productsData is List) {
          CartModel.products =
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
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ["Silver Road".text.fuchsia900.bold.xl2.makeCentered()],
      )),
    );
  }
}
