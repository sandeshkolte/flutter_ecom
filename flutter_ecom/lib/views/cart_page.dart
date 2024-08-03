import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/provider/order_provider.dart';
import 'package:flutter_ecom/widgets/productwidgets/remove_from_cart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/cart_model.dart';
import '../widgets/productwidgets/product_image.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
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
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return FutureBuilder(
          future: cartProvider.fetchCartFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return cartProvider.shoppingCart.isEmpty
                  ? "It's Empty Here!".text.xl3.makeCentered()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartProvider.shoppingCart.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                            product: cartProvider.shoppingCart[index]);
                      });
            }
          });
    });
  }
}

class CartItem extends StatelessWidget {
  final CartModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    debugPrint("PRODUCT INFO ${product.items.name} ");

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final now = DateTime.now().add(const Duration(days: 5));
    String formatter = DateFormat('EEE, MMMM d').format(now);

    return Container(
      // padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProductImage(image: product.items.image),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      product.items.name.text.xl.bold
                          .color(context.primaryColor)
                          .make(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => cartProvider.decrementQty(product.id),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Vx.slate200),
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                              ).p2(),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(product.quantity.toString()),
                          ),
                          InkWell(
                            onTap: () => cartProvider.incrementQty(product.id),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Vx.slate200),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                              ).p2(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              "₹".text.make(),
                              "${product.items.price}".text.bold.xl2.make(),
                            ],
                          ),
                          RemoveFromCart(product: product.items),
                        ],
                      ).py2(),
                      // const SizedBox(height: 8),
                      Row(
                        children: [
                          "FREE Delivery".text.make(),
                          formatter.text.bold.make().pOnly(left: 4)
                        ],
                      ).py(4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  _CartTotal();

  @override
  Widget build(BuildContext context) {
    Razorpay razorpay = Razorpay();

    final orderProvider = Provider.of<OrderProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    void handlePaymentSuccess(PaymentSuccessResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Successful".text.make()));

      // orderProvider.orderList.addAll(cartProvider.shoppingCart);
      // orderProvider.addOrder(cartProvider.);
    }

    void handlePaymentError(PaymentFailureResponse response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Payment Error".text.make()));
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);

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
            Consumer<OrderProvider>(
              builder: (context, value, child) => ElevatedButton(
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

                    // final amount = value.cartTotal * 100;

                    // var options = {
                    //   'key': 'rzp_test_9B43leN3Ot65ew',
                    //   'amount': amount,
                    //   'name': 'Silver Road',
                    //   'description': 'A one stop shopping platform',
                    //   'prefill': {
                    //     'contact': '8888888888',
                    //     'email': 'test@razorpay.com'
                    //   }
                    // };
                    // razorpay.open(options);

                    // orderProvider.orderList.add(cartProvider.shoppingCart.first);

                    // debugPrint("The cart Has ${cartProvider.shoppingCart.first}");

                    value.addOrder(cartProvider.shoppingCart.first, context);
                  },
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all(ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      backgroundColor: WidgetStateProperty.all(Vx.neutral800)),
                  child:
                      "Buy now".text.lg.center.white.bold.make().w32(context)),
            )
          ],
        );
      }),
    );
  }
}
