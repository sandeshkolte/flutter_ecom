import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:flutter_ecom/provider/wishlist_provider.dart';
import 'package:flutter_ecom/theme/themes.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../provider/product_provider.dart';
import '../../views/product_detail_page.dart';

class DisplayList extends StatelessWidget {
  const DisplayList({super.key});

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
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
            ),
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
                child: DisplayItem(product: product),
              );
            },
          );
        }
      },
    );
  }
}

class DisplayItem extends StatelessWidget {
  final Items product;

  const DisplayItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: Key(product.id.toString()),
            child: Stack(children: [
              DisplayImage(image: product.image),
              Positioned(
                top: 0,
                right: 0,
                child: Consumer<WishListProvider>(
                  builder: (context, wishProvider, child) => IconButton(
                    iconSize: 20,
                    padding: const EdgeInsets.all(2),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(MyTheme.blackBlakish)),
                    onPressed: () {
                      if (wishProvider.wishList.contains(product)) {
                        wishProvider.removeList(product);
                      } else {
                        wishProvider.addToList(product);
                      }
                    },
                    icon: wishProvider.wishList.contains(product)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                  ),
                ).p4(),
              )
            ]),
          ),
          const Spacer(), // Add spacer to push the text to the bottom
          product.name.text.bold
              .maxLines(1)
              .overflow(TextOverflow.ellipsis)
              .color(context.primaryColor)
              .make()
              .p2(),
        ],
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String image;
  const DisplayImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p3
        .color(context.canvasColor)
        .make()
        .p8()
        // .hPCT(context: context, heightPCT: 100)
        .wPCT(context: context, widthPCT: 40);
  }
}
