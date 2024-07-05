// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecom/common/common.dart';
// import 'package:http/http.dart' as http;

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passController = TextEditingController();
//   final TextEditingController unameController = TextEditingController();

//   Future<void> register(String uname, String email, String pass) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$baseUrl/users/register"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'username': uname,
//           'email': email,
//           'password': pass,
//         }),
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body.toString());
//         debugPrint(data.toString());
//         showSnakBar('Registration successful!', context);
//       } else {
//         debugPrint("Failed data sending ${response.statusCode}");
//         showSnakBar(
//             'Failed to register. Code: ${response.statusCode}', context);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//       showSnakBar('Error: $e', context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register Page'),
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Card(
//           elevation: 4.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: 'Username',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)))),
//                   controller: unameController,
//                 ),
//                 const SizedBox.shrink(),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)))),
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)))),
//                   controller: passController,
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await register(
//                       unameController.text,
//                       emailController.text,
//                       passController.text,
//                     );
//                   },
//                   style: ButtonStyle(
//                     padding: const WidgetStatePropertyAll(
//                         EdgeInsets.symmetric(horizontal: 20, vertical: 2)),
//                     foregroundColor:
//                         const WidgetStatePropertyAll<Color>(Colors.white),
//                     backgroundColor: WidgetStatePropertyAll<Color>(
//                       Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   child: const Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
