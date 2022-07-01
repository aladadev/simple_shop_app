import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderData;
  const OrderItemWidget({Key? key, required this.orderData}) : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderData.amount}'),
            subtitle: Text('Date Format korbo with intl'),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          Divider(),
          if (_isExpanded)
            Container(
              color: Colors.grey.shade100,
              margin: EdgeInsets.symmetric(vertical: 10),
              height: widget.orderData.products.length * 20 + 70,
              child: ListView(children: [
                ...widget.orderData.products
                    .map((e) => ListTile(
                          leading: IconButton(
                            onPressed: () {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .deleteProductFromOrder(widget.orderData, e);
                            },
                            icon: Icon(Icons.clear),
                          ),
                          trailing: Text('${e.price * e.quantity}'),
                          title: Text(e.title),
                          subtitle: Text('1x ${e.quantity} pcs'),
                        ))
                    .toList()
              ]),
            ),
          TextButton(
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false)
                    .deleteOrder(widget.orderData);
              },
              child: Text('clear'))
        ],
      ),
    );
  }
}
