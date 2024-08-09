import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecom/provider/wishlist_provider.dart';
import 'package:flutter_ecom/theme/themes.dart';
import 'package:flutter_ecom/widgets/app-banners.dart';
import 'package:flutter_ecom/widgets/productwidgets/newhomelist.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  final _controller = CarouselController();
  // final wishListProvider = WishListProvider();

  @override
  Widget build(BuildContext context) {
    List<Widget> myItems = [
      AppBanners(
          width: context.screenWidth,
          imageUrl: "assets/images/app-banner1.png"),
      AppBanners(
          width: context.screenWidth,
          imageUrl: "assets/images/app-banner2.png"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SizedBox(
          width: 200,
          child: Image(
              fit: BoxFit.cover, image: AssetImage("assets/images/logo.png")),
        ),
        actions: [
          Consumer<WishListProvider>(
            builder: (BuildContext context, WishListProvider wishListProvider,
                    Widget? child) =>
                IconButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(context.canvasColor)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/wish');
                        },
                        icon: const Icon(Icons.notifications_none_rounded))
                    .badge(
              position: VxBadgePosition.rightTop,
              count: wishListProvider.wishList.length,
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: SearchBar(
                    hintText: "Search Product",
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    shadowColor: WidgetStatePropertyAll(context.canvasColor),
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 30,
                      ),
                    ),
                    backgroundColor:
                        WidgetStatePropertyAll(context.canvasColor)),
              ),
              10.heightBox,
              SizedBox(
                height: 200,
                width: context.screenWidth,
                child: CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: myItems.length,
                    itemBuilder: (context, index, _) {
                      return myItems[index];
                    },
                    options: CarouselOptions(
                        enlargeFactor: 0.4,
                        enlargeCenterPage: true,
                        initialPage: 0,
                        height: 200,
                        autoPlay: true,
                        scrollDirection: Axis.horizontal)),
              ),
              const Expanded(child: MyCustomTab())
            ],
          ),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                overlayColor: WidgetStateColor.transparent,
                indicator: BoxDecoration(
                    color: MyTheme.blackBlakish,
                    borderRadius: BorderRadius.circular(50)),
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                      child: const Text("Trending"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                      child: const Text("Offers"),
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
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: const DisplayList());
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
