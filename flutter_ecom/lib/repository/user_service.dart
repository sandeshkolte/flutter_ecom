import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:http/http.dart' as http;
import '../common/common.dart';
import '../models/user_model.dart';

class UserService {
  final sharedPref = SharedPref();

  Future<User> fetchUser() async {
    try {
      final userId = await sharedPref.getUid();
      if (userId == null) {
        throw Exception("User ID is null");
      }
      final response =
          await http.post(Uri.parse('$baseUrl/users/getuser?userid=$userId'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final userData = decodedData["response"];
        debugPrint("User Data: $userData");

        return User.fromMap(userData);
      } else {
        throw Exception("No Data: userData status code error");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
      throw Exception('Failed to Load data: $e');
    }
  }
}
