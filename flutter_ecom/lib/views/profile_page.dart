import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/provider/order_provider.dart';
import 'package:provider/provider.dart';
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
        Navigator.pushNamed(context, '/');
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  var userData;

  Future<void> fetchUser() async {
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
        userData = decodedData["response"];
        debugPrint("User Data: $userData");
      } else {
        throw Exception("No Data: userData status code error");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
      throw Exception('Failed to Load data: $e');
    }
  }

  late Future<void> futureUserModel;

  @override
  void initState() {
    super.initState();
    futureUserModel = fetchUser();
  }

  final cartProvider = CartProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Profile".text.make(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logoutUser,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: futureUserModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      foregroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2017/07/18/23/23/user-2517433_1280.png"),
                    ).centered(),
                    20.heightBox,
                    "${userData['username']}".text.lg.makeCentered(),
                    "${userData['email']}".text.lg.makeCentered(),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/orders');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                    colors: [Vx.slate100, Vx.slate200])),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30.0),
                              child: Consumer<OrderProvider>(
                                builder: (BuildContext context,
                                        OrderProvider value, Widget? child) =>
                                    Column(
                                  children: [
                                    "Orders".text.lg.make(),
                                    value.orderList.length.text.make()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  colors: [Vx.slate100, Vx.slate200])),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 18.0),
                            child: Column(
                              children: [
                                "Wishlist".text.lg.make(),
                                "5".text.make()
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ).expand(),
        ],
      ),
    );
  }
}
