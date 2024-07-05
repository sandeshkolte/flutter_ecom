import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductImage extends StatelessWidget {
  final String image;
  const ProductImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p3
        .color(context.canvasColor)
        .make()
        .p8().hPCT(context: context, heightPCT: 100)
        .wPCT(context: context, widthPCT: context.isMobile?40:20);
  }
}
