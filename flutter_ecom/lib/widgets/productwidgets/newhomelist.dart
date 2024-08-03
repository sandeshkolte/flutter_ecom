import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../provider/product_provider.dart';
import '../../views/product_detail_page.dart';
import 'product_image.dart';

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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
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
    return VxBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: Key(product.id.toString()),
            child: ProductImage(image: product.image),
          ),
          const Spacer(), // Add spacer to push the text to the bottom
          product.name.text.bold.color(context.primaryColor).make().p2(),
        ],
      ),
    ).color(context.cardColor).rounded.square(300).make().p4();
  }
}
