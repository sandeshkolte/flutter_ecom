import 'package:flutter/material.dart';

void showSnakBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

const baseUrl = "https://flutter-ecom.onrender.com";