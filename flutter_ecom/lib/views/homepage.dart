import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/views/cart_page.dart';
import 'package:flutter_ecom/views/orders_page.dart';
import 'package:flutter_ecom/views/profile_page.dart';
import 'package:flutter_ecom/views/shop_page.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const ShopPage(),
    const OrdersPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);

    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, value, child) => Scaffold(
        body: _pages[value],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.cart).badge(
                position: VxBadgePosition.right,
                count: _cartProvider.shoppingCart.length,
                color: Colors.transparent,
                size: 20,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Vx.slate200,
          currentIndex: value,
          selectedItemColor: Vx.slate800,
          unselectedItemColor: Vx.slate500,
          showUnselectedLabels: false,
          useLegacyColorScheme: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
