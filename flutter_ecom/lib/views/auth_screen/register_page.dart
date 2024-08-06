import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../common/common.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController unameController = TextEditingController();
  final sharedPref = SharedPref();

  @override
  void dispose() {
    emailController.clear();
    passController.clear();
    unameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> register(String uname, String email, String pass) async {
      try {
        debugPrint("Regiser funtiocn");
        final response = await http.post(
          Uri.parse("$baseUrl/users/register"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': uname,
            'email': email,
            'password': pass,
          }),
        );

        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          var uid = decodedData["response"]["createdUser"]["_id"];
          debugPrint(uid);
          sharedPref.setUid(uid);
          showSnakBar('Registration successful!', context);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          debugPrint("Failed data sending ${response.statusCode}");
          showSnakBar(
              'Failed to register. Code: ${response.statusCode}', context);
        }
      } catch (e) {
        debugPrint(e.toString());
        showSnakBar('Error: $e', context);
      }
    }

    return Scaffold(
        backgroundColor: const Color(0xfff6f3eb),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: context.screenWidth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/app-banner2.png"))),
              ),
              50.heightBox,
              "Register"
                  .text
                  .xl4
                  .color(const Color.fromARGB(255, 64, 57, 41))
                  .textStyle(GoogleFonts.niconne())
                  .makeCentered(),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
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
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 53, 47, 32)),
                                    controller: unameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 64, 57, 41)))),
                                  child: TextFormField(
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
                                  child: TextFormField(
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
                            onTap: () {
                              if (unameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                register(unameController.text,
                                    emailController.text, passController.text);
                              } else {
                                showSnakBar('Please fill all fields', context);
                              }
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 90, 83, 67),
                                      Color.fromARGB(255, 139, 132, 115)
                                    ])),
                                child: "Create Account"
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
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: const Text(
                              "Already have an Account? Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 64, 57, 41)),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
