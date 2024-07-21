import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final sharedPref = SharedPref();

    if (sharedPref.getUid.toString() !="") {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context,'/home');
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context,'/');
      });
    }
  }
}
