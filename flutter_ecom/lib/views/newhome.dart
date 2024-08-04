import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecom/theme/themes.dart';
import 'package:flutter_ecom/widgets/productwidgets/newhomelist.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "MINIMILIST".text.make(),
        actions: [
          IconButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(context.canvasColor)),
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: SearchBar(
                hintText: "Search Product",
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                shadowColor: WidgetStatePropertyAll(context.canvasColor),
                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 30,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(context.canvasColor)),
          ),
          Container(
            height: 180,
            width: context.screenWidth,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/app-banner.png"))),
          ).innerShadow(
              offset: const Offset(0, -10),
              color: Colors.black.withOpacity(.5),
              blur: 12),
          const Expanded(child: MyCustomTab())
        ],
      ),
    );
  }
}

class MyCustomTab extends StatefulWidget {
  const MyCustomTab({super.key});

  @override
  State<MyCustomTab> createState() => _MyCustomTabState();
}

class _MyCustomTabState extends State<MyCustomTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_literals_to_create_immutables
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              child: TabBar(
                overlayColor: WidgetStateColor.transparent,
                indicator: BoxDecoration(
                    color: MyTheme.blackBlakish,
                    borderRadius: BorderRadius.circular(50)),
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                      child: Text("Trending"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                      child: Text("Offers"),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                MyTabOne(),
                MyTabTwo(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class MyTabOne extends StatelessWidget {
  const MyTabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const DisplayList();
  }
}

class MyTabTwo extends StatelessWidget {
  const MyTabTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "This is Tab One",
      style: TextStyle(fontSize: 20),
    ));
  }
}
