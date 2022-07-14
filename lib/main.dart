import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        title: 'Shop App',
        home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeID: (context) => ProductsOverviewScreen(),
          ProductDetail.routeID: (context) => ProductDetail(),
          CartScreen.routeID: (context) => CartScreen(),
          OrderScreen.routeID: (context) => OrderScreen(),
          UserProductScreen.routeID: (context) => UserProductScreen(),
          EditProductScreen.routeID: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
