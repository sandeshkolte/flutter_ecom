import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:flutter_ecom/provider/wishlist_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/add_to_cart.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/productwidgets/product_image.dart';
import 'product_detail_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: "Wishlist".text.make(),
      ),
      body: Container(margin: const EdgeInsets.all(8), child: _Wishlist()),
    );
  }
}

class _Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(builder: (context, wishProvider, child) {
      if (wishProvider.wishList.isEmpty) {
        return "It's Empty Here!".text.xl3.makeCentered();
      } else {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 4,
            childAspectRatio: 0.64,
          ),
          itemCount: wishProvider.wishList.length,
          itemBuilder: (context, index) {
            final product = wishProvider.wishList[index];
            return InkWell(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    ),
                child: GridTile(
                  child: WishItem(product: product),
                ));
          },
        );
      }
    });
  }
}

class WishItem extends StatelessWidget {
  final Items product;

  const WishItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          WishImage(image: product.image),
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.name.text.lg.bold
                    .color(context.primaryColor)
                    .make()
                    .p2(),
                product.description.text
                    .overflow(TextOverflow.ellipsis)
                    .maxLines(1)
                    .lg
                    .bold
                    .make()
                    .p2()
                    .expand(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "₹".text.make(),
                    "${product.price}".text.bold.xl2.make(),
                  ],
                ),
                AddToCart(product: product)
              ],
            ).px8(),
          ),
        ],
      ),
    );
  }
}

class WishImage extends StatelessWidget {
  final String image;

  const WishImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p3
        .color(context.canvasColor)
        .make()
        .p8()
        .hPCT(context: context, heightPCT: 20);
  }
}
