import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ecom/views/shop_page.dart';
// import 'package:page_transition/page_transition.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  InitPageState createState() => InitPageState();
}

class InitPageState extends State<InitPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.4),
          ])),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Brand New Perspective",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: const Text(
                      "Let's start with our summer collection.",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  // onTap: () {
                  //   Navigator.pushNamed(context, '/home');
                  // },
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                            child: Text(
                          "Get Started",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
