import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/product_model.dart';
import '../widgets/productwidgets/add_to_cart.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Items product;

  @override
  Widget build(BuildContext context) {
    final mrpAmount = product.discount + product.price;

    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mrpAmount.text
                    .textStyle(
                        const TextStyle(decoration: TextDecoration.lineThrough))
                    .lg
                    .make()
                    .pOnly(right: 5),
                "₹".text.xl2.bold.green700.make(),
                "${product.price}".text.bold.green700.xl4.make(),
              ],
            ),
            AddToCart(product: product)
          ],
        ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                tag: Key(product.id.toString()),
                child:
                    Image.network(product.image).centered().h32(context).p(5)),
            Expanded(
                child: VxArc(
              height: 20.0,
              edge: VxEdge.top,
              arcType: VxArcType.convey,
              child: Container(
                width: context.screenWidth,
                color: context.cardColor,
                child: Column(
                  children: [
                    product.name.text.xl4.bold
                        .color(context.primaryColor)
                        .make(),
                    product.description.text.lg
                        .textStyle(context.captionStyle)
                        .make()
                        .p32(),
                    Container(
                      width: (context).screenWidth,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          product.stock <= 0
                              ? "Out of Stock".text.lg.bold.red500.make()
                              : product.stock == 1
                                  ? "Only ${product.stock} left in stock"
                                      .text
                                      .lg
                                      .bold
                                      .red500
                                      .make()
                                  : "Only ${product.stock} left in stock"
                                      .text
                                      .lg
                                      .bold
                                      .emerald500
                                      .make(),
                          ElevatedButton(
                            onPressed: null,
                            child: product.category.text.black.make(),
                          ).py4(),
                        ],
                      ),
                    ),
                    Container(
                      width: (context).screenWidth,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Vx.neutral100),
                      child: Row(
                        children: [
                          "Seller : ".text.xl.bold.make(),
                          product.seller.text.lg.make()
                        ],
                      ).p12(),
                    )
                  ],
                ).py16(),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
