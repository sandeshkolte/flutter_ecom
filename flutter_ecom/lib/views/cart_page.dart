import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/provider/order_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/remove_from_cart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../common/common.dart';
import '../common/shared_pref.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../widgets/productwidgets/product_image.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Future<void> getCart() async {
  //   try {
  //     final response = await http.get(Uri.parse('$baseUrl/products'));
  //     debugPrint(response.body.toString());
  //     if (response.statusCode == 200) {
  //       final decodedData = jsonDecode(response.body);
  //       final productsData = decodedData["response"];
  //       if (productsData is List) {
  //         CartModel.products =
  //             productsData.map<Items>((item) => Items.fromMap(item)).toList();
  //       } else {
  //         debugPrint("No Data: productsData is not a List");
  //       }
  //       setState(() {});
  //     } else {
  //       debugPrint("Response failed with code ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to Load data: $e');
  //   }
  // }

  // var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Cart".text.color(context.primaryColor).make(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _CartList().p16().expand(),
          Consumer<CartProvider>(
              builder: (context, value, child) => value.shoppingCart.isNotEmpty
                  ? const PriceDetails()
                  : "".text.make()),
          const Divider(),
          _CartTotal()
          // Consumer<CartProvider>(
          //     builder: (context, value, child) => _CartTotal(value.product)),
        ],
      ),
    );
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      final mrpPrice = value.cartSubtotal + value.cartDiscount;

      return Container(
        margin: const EdgeInsets.all(20),
        width: (context).screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Price Details".text.lg.bold.make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["MRP:".text.make(), "$mrpPrice".text.make()],
            ).py4(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Discount:".text.make(),
                "-${value.cartDiscount}".text.make()
              ],
            ).py4(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Shipping Charge:".text.make(),
                "${value.shippingCharge}".text.make(),
              ],
            ).py4(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Total:".text.lg.bold.make(),
                "${value.cartTotal}".text.lg.bold.make(),
              ],
            ).py8(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                "You save ₹${value.cartDiscount.toInt()}"
                    .text
                    .lg
                    .bold
                    .color(Vx.emerald500)
                    .make(),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final CartModel _cart = (VxState.store as MyStore).cart;
    final cartProvider = Provider.of<CartProvider>(context);

    return FutureBuilder(
        future: cartProvider.fetchCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (cartProvider.shoppingCart.isEmpty) {
            return "It's Empty Here!".text.xl3.makeCentered();
          } else {
            return ListView.builder(
                itemCount: cartProvider.shoppingCart.length,
                itemBuilder: (context, index) {
                  return CartItem(product: cartProvider.shoppingCart[index]);
                });
          }
        });
  }
}

class CartItem extends StatelessWidget {
  final CartModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final now = DateTime.now().add(const Duration(days: 5));
    String formatter = DateFormat('EEE,MMMMd').format(now);

    var children2 = [
      ListView.builder(
          shrinkWrap: true,
          itemCount: cartProvider.shoppingCart.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ProductImage(image: product.items.image),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      product.items.name.text.xl.bold
                          .color(context.primaryColor)
                          .make(),
                      Consumer<CartProvider>(
                        builder: (context, value, child) => ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () => value.decrementQty(product.id),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Vx.slate200),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 20,
                                    ).p2())),
                            Text(product.quantity.toString()),
                            InkWell(
                                onTap: () => value.incrementQty(product.id),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Vx.slate200),
                                    child: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ).p2())),
                          ],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        buttonPadding: EdgeInsets.zero,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "₹".text.make(),
                              "${product.items.price}".text.bold.xl2.make(),
                            ],
                          ),
                          RemoveFromCart(product: product.items)
                        ],
                      ).pOnly(right: 8),
                      Row(
                        children: [
                          "FREE Delivery".text.make(),
                          formatter.text.bold.make().pOnly(left: 4)
                        ],
                      ).py(4)
                    ],
                  ).p(context.isMobile ? 2 : 16),
                ),
              ],
            );
          })
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
        .py8();
  }
}

class _CartTotal extends StatelessWidget {
  _CartTotal();
  // late Items product;

  //  final OrderModel product;

  @override
  Widget build(BuildContext context) {
    Razorpay razorpay = Razorpay();

    final orderProvider = Provider.of<OrderProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    void handlePaymentSuccess(PaymentSuccessResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Successful".text.make()));

      orderProvider.orderList.addAll(cartProvider.shoppingCart);
      orderProvider.addOrder(cartProvider.product);
    }

    void handlePaymentError(PaymentFailureResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Error".text.make()));
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);

    // @override
    // void dispose() {
    //   razorpay.clear();
    //   super.dispose();
    // }

    return SizedBox(
      height: 100,
      child: Consumer<CartProvider>(builder: (context, value, child) {
        final buyPrice = value.cartTotal - value.shippingCharge;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "₹".text.xl2.bold.color(context.primaryColor).make(),
                "$buyPrice".text.xl4.color(context.primaryColor).make()
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (buyPrice == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: "No item in cart".text.black.make(),
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Vx.indigo300,
                    ));
                    return;
                  }

                  final amount = value.cartTotal * 100;

                  var options = {
                    'key': 'rzp_test_9B43leN3Ot65ew',
                    'amount': amount,
                    'name': 'Silver Road',
                    'description': 'A one stop shopping platform',
                    'prefill': {
                      'contact': '8888888888',
                      'email': 'test@razorpay.com'
                    }
                  };
                  razorpay.open(options);
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    backgroundColor:
                        const WidgetStatePropertyAll(Vx.neutral800)),
                child: "Buy now".text.lg.center.white.bold.make().w32(context))
          ],
        );
      }),
    );
  }
}
