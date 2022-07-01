import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeID = 'product-detail-screen';
  // final String title;
  // const ProductDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findByID(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Price: \$${loadedProduct.price}'),
          SizedBox(
            height: 10,
          ),
          Text(loadedProduct.description)
        ],
      ),
    );
  }
}
