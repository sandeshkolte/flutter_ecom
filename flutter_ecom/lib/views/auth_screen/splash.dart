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
