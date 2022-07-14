import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hola Gentleman!'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_rounded),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductsOverviewScreen.routeID);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_rounded),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.routeID);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Products'),
            onTap: () {
              Navigator.pushNamed(context, UserProductScreen.routeID);
            },
          ),
        ],
      ),
    );
  }
}
