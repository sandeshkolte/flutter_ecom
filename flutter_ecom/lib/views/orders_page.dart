import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:flutter_ecom/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/productwidgets/product_image.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: "Orders".text.make(),
        actions: [
          IconButton(
              onPressed: () {
                final orderProvider = OrderProvider();

                orderProvider.fetchOrderFuture;
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Column(
        children: [
          _OrderList().p16().expand(),
        ],
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final OrderModel _Order = (VxState.store as MyStore).Order;
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return FutureBuilder(
          future: orderProvider.fetchOrderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return orderProvider.orderList.isEmpty
                  ? "It's Empty Here!".text.xl3.makeCentered()
                  : ListView.builder(
                      itemCount: orderProvider.orderList.length,
                      itemBuilder: (context, index) {
                        return OrderItem(
                            product: orderProvider.orderList[index]);
                      });
            }
          });
    });
  }
}

class OrderItem extends StatelessWidget {
  final CartModel product;

  const OrderItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var children2 = [
      ProductImage(image: product.items.image),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.items.name.text.lg.bold.color(context.primaryColor).make(),
            "Status: ${product.orderStatus}".text.lg.bold.emerald800.make(),
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
        .square(100)
        .make()
        .py8();
  }
}
