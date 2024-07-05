import 'package:flutter/material.dart';

void showSnakBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

const baseUrl = "http://192.168.167.167:9000";