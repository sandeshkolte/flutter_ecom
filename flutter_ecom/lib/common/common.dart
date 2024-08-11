import 'package:flutter/material.dart';

void showSnakBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

const baseUrl = "https://flutter-ecom.onrender.com";
// const baseUrl = "http://192.168.1.22:3000";
