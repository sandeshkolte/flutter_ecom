import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppBanners extends StatelessWidget {
  const AppBanners({super.key, required this.width, required this.imageUrl});
  final double width;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imageUrl))),
    ).innerShadow(
        offset: const Offset(0, -10),
        color: Colors.black.withOpacity(.5),
        blur: 12);
  }
}
