// import 'package:flutter/material.dart';
// import 'package:flutter_ecom/models/cart_model.dart';
// import 'package:flutter_ecom/provider/order_provider.dart';
// import 'package:flutter_ecom/provider/wishlist_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:velocity_x/velocity_x.dart';
// import '../widgets/productwidgets/product_image.dart';

// class WishlistPage extends StatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.canvasColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Colors.transparent,
//         title: "Wishlist".text.make(),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 final wishProvider = WishListProvider();

//                 wishProvider.fetchOrderFuture;
//               },
//               icon: const Icon(Icons.refresh_rounded))
//         ],
//       ),
//       body: Column(
//         children: [
//           _Wishlist().p16().expand(),
//         ],
//       ),
//     );
//   }
// }

// class _Wishlist extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final OrderModel _Order = (VxState.store as MyStore).Order;
//     return Consumer<WishListProvider>(builder: (context, wishProvider, child) {
//       return FutureBuilder(
//           future: wishProvider.fetchOrderFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               return wishProvider.wishList.isEmpty
//                   ? "It's Empty Here!".text.xl3.makeCentered()
//                   : ListView.builder(
//                       itemCount: wishProvider.wishList.length,
//                       itemBuilder: (context, index) {
//                         return OrderItem(
//                             product: wishProvider.wishList[index]);
//                       });
//             }
//           });
//     });
//   }
// }

// class OrderItem extends StatelessWidget {
//   final CartModel product;

//   const OrderItem({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     var children2 = [
//       ProductImage(image: product.items.image),
//       Expanded(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             product.items.name.text.lg.bold.color(context.primaryColor).make(),
//             "Status: ${product.orderStatus}".text.lg.bold.emerald800.make(),
//           ],
//         ).p(context.isMobile ? 2 : 16),
//       ),
//     ];
//     return VxBox(
//             child: context.isMobile
//                 ? Row(
//                     children: children2,
//                   )
//                 : Column(
//                     children: children2,
//                   ))
//         .color(context.cardColor)
//         .rounded
//         .square(100)
//         .make()
//         .py8();
//   }
// }
