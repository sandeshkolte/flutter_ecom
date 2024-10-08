import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../provider/product_provider.dart';
import '../../views/product_detail_page.dart';
import 'add_to_cart.dart';
import 'product_image.dart';

class ShopList extends StatelessWidget {
  const ShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return FutureBuilder(
        future: productProvider.fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: productProvider.items.length,
              itemBuilder: (context, index) {
                final product = productProvider.items[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  ),
                  child: ShopItem(product: product),
                );
              },
            );
          }
        });
  }
}

class ShopItem extends StatelessWidget {
  final Items product;

  const ShopItem({super.key, required this.product});

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
            10.heightBox,ButtonBar(
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
        .py4();
  }
}
