import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:flutter_ecom/provider/category_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/add_to_cart.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../views/product_detail_page.dart';
import 'product_image.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return FutureBuilder(
      future: categoryProvider.findbyCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return categoryProvider.items.isEmpty
              ? "It's Empty Here!".text.xl3.makeCentered()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryProvider.items.length,
                  itemBuilder: (context, index) {
                    final product = categoryProvider.items[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      ),
                      child: CategoryItem(product: product),
                    );
                  },
                );
        }
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Items product;

  const CategoryItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
        tag: Key(product.id.toString()),
        child: ProductImage(image: product.image),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.name.text.lg.bold.color(context.primaryColor).make(),
            product.description.text.lg
                .maxLines(2)
                .overflow(TextOverflow.ellipsis)
                .textStyle(context.captionStyle)
                .make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "₹".text.make(),
                    "${product.price}".text.bold.xl2.make(),
                  ],
                ),
                AddToCart(product: product)
              ],
            ).pOnly(right: 8),
          ],
        ).p(context.isMobile ? 2 : 16),
      )
    ];
    return VxBox(
            child: context.isMobile
                ? Row(
                    children: children2,
                  )
                : Column(
                    children: children2,
                  ))
        .color(context.cardColor)
        .rounded
        .square(180)
        .make()
        .py2();
  }
}
