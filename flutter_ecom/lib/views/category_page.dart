import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Category".text.make(),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: SearchBar(
                hintText: "Search Category",
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
          Expanded(
            child: ListView(children: [
              categoryItem(
                  context.screenWidth,
                  "https://th.bing.com/th/id/OIP.cK9yNwedmDVM5gegxl8gUAHaFQ?rs=1&pid=ImgDetMain",
                  "SMARTPHONE"),
              categoryItem(
                  context.screenWidth,
                  "https://th.bing.com/th/id/OIP.ef2M5mFJjgPqS4a87ggx3QHaE8?rs=1&pid=ImgDetMain",
                  "CLOTHES"),
              categoryItem(
                  context.screenWidth,
                  "https://c.pxhere.com/images/dd/fb/32f6e4c9eff8c290ca3466946ce7-1595236.jpg!d",
                  "ACCESSORIES")
            ]),
          )
        ],
      ),
    );
  }
}

Widget categoryItem(width, imageUrl, catName) {
  return Container(
    height: 180,
    width: width,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(offset: Offset(5, 5), color: Colors.black45, blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(25),
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 12)
            ]),
            child: "$catName".text.xl2.white.make().p12()),
      ],
    ),
  ).innerShadow(
      offset: const Offset(0, -10),
      color: Colors.black.withOpacity(.5),
      blur: 12);
}
