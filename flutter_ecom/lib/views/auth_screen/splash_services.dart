import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';

class SplashServices {
    final sharedPref = SharedPref();
  isLogin(BuildContext context) async{
    final userId = await sharedPref.getUid();
    debugPrint(userId);
    if (userId != null || userId!="") {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/home');
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/');
      });
    }
  }
}
