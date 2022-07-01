import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart_provider.dart';

class OrderItem {
  final String id;
  double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orderList = [];

  List<OrderItem> get orderItem {
    return [..._orderList];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orderList.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }

  void deleteOrder(OrderItem orderData) {
    _orderList.remove(orderData);
    notifyListeners();
  }

  void deleteProductFromOrder(OrderItem orderData, CartItem element) {
    orderData.products.remove(element);
    var price = orderData.amount - (element.price * element.quantity);
    orderData.amount = price;
    notifyListeners();
  }
}
