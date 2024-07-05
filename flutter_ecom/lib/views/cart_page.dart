import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/widgets/remove_from_cart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/cart_model.dart';
import '../widgets/productwidgets/product_image.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          const _CartTotal(),
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
    return Consumer<CartProvider>(
      builder: (context, value, child) => value.shoppingCart.isEmpty
          ? "It's Empty Here!".text.xl3.makeCentered()
          : ListView.builder(
              itemCount: value.shoppingCart.length,
              itemBuilder: (context, index) {
                return CartItem(product: value.shoppingCart[index]);
              }
              // ListTile(
              //   leading: const Icon(Icons.done),
              //   trailing: IconButton(
              //       icon: const Icon(Icons.remove_circle_outline),
              //       onPressed: () => value.removeFromCart(value.shoppingCart[index].items.id)),
              //   title: Text(value.shoppingCart[index].items.name.toString())
              // ),
              ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().add(const Duration(days: 5));
    String formatter = DateFormat('EEE,MMMMd').format(now);

    var children2 = [
      ProductImage(image: product.items.image),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.items.name.text.xl.bold.color(context.primaryColor).make(),
            // product.items.description.text.lg.maxLines(2).overflow(TextOverflow.ellipsis).textStyle(context.captionStyle).make(),
            // 10.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
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
            Consumer<CartProvider>(
              builder: (context, value, child) => ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () => value.decrementQty(product.id),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
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
                              borderRadius: BorderRadius.circular(100),
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

class _CartTotal extends StatefulWidget {
  const _CartTotal();

  @override
  State<_CartTotal> createState() => _CartTotalState();
}

class _CartTotalState extends State<_CartTotal> {
  @override
  Widget build(BuildContext context) {
    Razorpay razorpay = Razorpay();

    void handlePaymentSuccess(PaymentSuccessResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Successful".text.make()));
    }

    void handlePaymentError(PaymentFailureResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Error".text.make()));
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);

    @override
    void dispose() {
      razorpay.clear();
      super.dispose();
    }

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
                    'key': 'rzp_live_ILgsfZCZoFIKMb',
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
