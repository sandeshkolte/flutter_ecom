import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/cart_provider.dart';
import 'package:flutter_ecom/provider/category_provider.dart';
import 'package:flutter_ecom/provider/imageurl_provider.dart';
import 'package:flutter_ecom/provider/order_provider.dart';
import 'package:flutter_ecom/provider/product_provider.dart';
import 'package:flutter_ecom/provider/user_provider.dart';
import 'package:flutter_ecom/provider/wishlist_provider.dart';
import 'package:flutter_ecom/views/auth_screen/splash.dart';
import 'package:flutter_ecom/views/cart_page.dart';
import 'package:flutter_ecom/views/category_page.dart';
import 'package:flutter_ecom/views/homepage.dart';
import 'package:flutter_ecom/views/init_page.dart';
import 'package:flutter_ecom/views/newhome.dart';
import 'package:flutter_ecom/views/orders_page.dart';
import 'package:flutter_ecom/views/profile_page.dart';
// import 'package:flutter_ecom/views/login_page.dart';
// import 'package:flutter_ecom/views/register_page.dart';
import 'package:flutter_ecom/views/shop_page.dart';
import 'package:flutter_ecom/views/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/themes.dart';
import 'views/auth_screen/login_page.dart';
import 'views/auth_screen/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ImageUrlProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => WishListProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const InitPage(),
        '/splash': (context) => const SplashScreen(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const Loginpage(),
        '/home': (context) => const HomePage(),
        '/newhome': (context) => const NewHome(),
        '/category': (context) => const CategoryPage(),
        '/orders': (context) => const OrdersPage(),
        '/profile': (context) => const ProfilePage(),
        '/wish': (context) => const WishlistPage(),
        '/shop': (context) => const ShopPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
