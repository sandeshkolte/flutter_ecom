import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../common/common.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final sharedPref = SharedPref();

  Future<void> loginUser(String email, String pass) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': pass,
        }),
      );

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var uid = decodedData["response"]["user"]["_id"];
        debugPrint(uid);
        sharedPref.setUid(uid);
      } else {
        debugPrint("Failed data sending ${response.statusCode}");
        showSnakBar('Failed to login. Code: ${response.statusCode}', context);
      }
    } catch (e) {
      debugPrint(e.toString());
      showSnakBar('Error: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f3eb),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(

              //   height: 400,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('assets/images/loginbackground.png'),
              //           fit: BoxFit.fill)),
              //   child: Stack(
              //     children: <Widget>[
              //       Positioned(
              //         left: 30,
              //         width: 80,
              //         height: 200,
              //         child: FadeInUp(
              //             duration: const Duration(seconds: 1),
              //             child: Container(
              //               decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                       image: AssetImage(
              //                           'assets/images/light-1.png'))),
              //             )),
              //       ),
              //       Positioned(
              //         left: 140,
              //         width: 80,
              //         height: 150,
              //         child: FadeInUp(
              //             duration: const Duration(milliseconds: 1200),
              //             child: Container(
              //               decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                       image: AssetImage(
              //                           'assets/images/light-2.png'))),
              //             )),
              //       ),
              //       Positioned(
              //         right: 40,
              //         top: 40,
              //         width: 80,
              //         height: 150,
              //         child: FadeInUp(
              //             duration: const Duration(milliseconds: 1300),
              //             child: Container(
              //               decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                       image:
              //                           AssetImage('assets/images/clock.png'))),
              //             )),
              //       ),
              //       Positioned(
              //         child: FadeInUp(
              //             duration: const Duration(milliseconds: 1600),
              //             child: Container(
              //               margin: const EdgeInsets.only(top: 50),
              //               child: const Center(
              //                 child: Text(
              //                   "Login",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 40,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //             )),
              //       )
              //     ],
              //   ),
              // ),
              Container(
                height: 200,
                width: context.screenWidth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/app-banner2.png"))),
              ),
              50.heightBox,
              "Login"
                  .text
                  .xl4
                  .color(const Color.fromARGB(255, 64, 57, 41))
                  .textStyle(GoogleFonts.niconne())
                  .makeCentered(),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f3eb),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(255, 64, 57, 41)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 64, 57, 41)))),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 53, 47, 32)),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[700])),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 53, 47, 32)),
                                  controller: passController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[700])),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1900),
                        child: InkWell(
                          onTap: () async {
                            await loginUser(
                                emailController.text, passController.text);
                            Navigator.pushReplacementNamed(context, '/home');
                            showSnakBar('Login successful!', context);
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 90, 83, 67),
                                    Color.fromARGB(255, 139, 132, 115)
                                  ])),
                              child: "Login"
                                  .text
                                  .lg
                                  .textStyle(GoogleFonts.tinos())
                                  .white
                                  .makeCentered()),
                        )),
                    const SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/register'),
                      child: FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromARGB(255, 64, 57, 41)),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
