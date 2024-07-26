import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../views/product_detail_page.dart';
import 'add_to_cart.dart';
import 'product_image.dart';

class ShopList extends StatelessWidget {
  const ShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: ProductModel.items!.length,
            itemBuilder: (context, index) {
              final product = ProductModel.items![index];
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: ProductModel.items!.length,
            itemBuilder: (context, index) {
              final product = ProductModel.items![index];
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
}

class ShopItem extends StatelessWidget {
  final Items product;

  const ShopItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now().add(const Duration(days: 5));
    // String formatter = DateFormat('EEE,MMMMd').format(now);

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
            // Row(mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     "4.5".text.blue500.make().pOnly(right: 5),
            //     VxRating(
            //       onRatingUpdate: (value) {},
            //       count: 5,maxRating: 10,
            //       normalColor: Colors.grey,
            //       selectionColor: Colors.yellow,
            //       size: 20,
            //     ),
            //     "(2,643)".text.make().pOnly(left: 5)
            //   ],
            // ).py4(),
            // "400+ bought in past month".text.make().py4(),
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

            // Row(
            //   children: [
            //     "FREE Delivery".text.make(),
            //     formatter.text.bold.make().pOnly(left: 4)
            //   ],
            // ).py(4)
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
