import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/widgets/productwidgets/category_list.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ValueNotifier<String> category = ValueNotifier<String>("SmartPhone");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Category".text.make(),
      ),
      body: ValueListenableBuilder(
        valueListenable: category,
        builder: (context, value, child) => Column(
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
                backgroundColor: WidgetStatePropertyAll(context.canvasColor),
              ),
            ),
            10.heightBox,
            Wrap(
              spacing: 4,
              children: [
                ElevatedButton(
                  onPressed: () => category.value = "SmartPhone",
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: "SmartPhone".text.black.make(),
                ),
                ElevatedButton(
                  onPressed: () => category.value = "Earbuds",
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: "Earbuds".text.black.make(),
                ),
                ElevatedButton(
                  onPressed: () => category.value = "Laptops",
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: "Laptops".text.black.make(),
                ),
                ElevatedButton(
                  onPressed: () => category.value = "Wearables",
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: "Wearables".text.black.make(),
                ),
                ElevatedButton(
                  onPressed: () => category.value = "Consoles",
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(StadiumBorder()),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: "Consoles".text.black.make(),
                ),
              ],
            ).px2(),
            Expanded(child: CategoryList(category: value)),
          ],
        ),
      ),
    );
  }
}
