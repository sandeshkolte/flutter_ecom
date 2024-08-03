import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../common/common.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final sharedPref = SharedPref();

  Future<void> logoutUser() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/logout'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final data = decodedData["response"];
        sharedPref.setUid("");
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
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Profile".text.make(),
      ),
      body: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutUser();
              Navigator.pushNamed(context, '/');
            },
          )
        ],
      ),
    );
  }
}
