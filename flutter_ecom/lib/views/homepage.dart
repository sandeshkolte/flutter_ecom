import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/theme/themes.dart';
import 'package:flutter_ecom/views/cart_page.dart';
import 'package:flutter_ecom/views/category_page.dart';
import 'package:flutter_ecom/views/newhome.dart';
import 'package:flutter_ecom/views/orders_page.dart';
import 'package:flutter_ecom/views/profile_page.dart';
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
    const NewHome(),
    const CategoryPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, value, child) => Scaffold(
            body: Column(
              children: [
                Expanded(child: _pages[value]),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: BottomNavigationBar(
                        items: <BottomNavigationBarItem>[
                          const BottomNavigationBarItem(
                            activeIcon: Icon(
                              Icons.wifi_1_bar_rounded,
                              size: 30,
                            ),
                            icon: Icon(CupertinoIcons.home),
                            label: 'Home',
                          ),
                          const BottomNavigationBarItem(
                            activeIcon: Icon(
                              Icons.wifi_1_bar_rounded,
                              size: 30,
                            ),
                            icon: Icon(Icons.category),
                            label: 'Categories',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: const Icon(
                              Icons.wifi_1_bar_rounded,
                              size: 30,
                            ),
                            icon: const Icon(CupertinoIcons.cart).badge(
                              position: VxBadgePosition.right,
                              count: cartProvider.shoppingCart.length,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            label: 'Cart',
                          ),
                          const BottomNavigationBarItem(
                            activeIcon: Icon(
                              Icons.wifi_1_bar_rounded,
                              size: 30,
                            ),
                            icon: Icon(Icons.person),
                            label: 'Profile',
                          ),
                        ],
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: MyTheme.blackBlakish,
                        currentIndex: value,
                        selectedItemColor: Colors.orange,
                        unselectedItemColor: Vx.slate100,
                        showUnselectedLabels: false,
                        onTap: _onItemTapped,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   items: <BottomNavigationBarItem>[
            //     const BottomNavigationBarItem(
            //       icon: Icon(CupertinoIcons.home),
            //       label: 'Home',
            //     ),
            //     const BottomNavigationBarItem(
            //       icon: Icon(Icons.category),
            //       label: 'Orders',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: const Icon(CupertinoIcons.cart).badge(
            //         position: VxBadgePosition.right,
            //         count: cartProvider.shoppingCart.length,
            //         size: 20,
            //         textStyle: const TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //       label: 'Cart',
            //     ),
            //     const BottomNavigationBarItem(
            //       icon: Icon(Icons.person),
            //       label: 'Profile',
            //     ),
            //   ],
            //   type: BottomNavigationBarType.fixed,
            //   elevation: 10,
            //   backgroundColor: MyTheme.blackBlakish,
            //   currentIndex: value,
            //   selectedItemColor: Colors.orange,
            //   unselectedItemColor: Vx.slate100,
            //   showUnselectedLabels: false,
            //   onTap: _onItemTapped,
            // ),
          ),
        );
      },
    );
  }
}
