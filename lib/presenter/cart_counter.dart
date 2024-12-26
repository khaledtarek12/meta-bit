// import 'dart:async';

// import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
// import 'package:flutter/material.dart';

// class CartCounter extends ChangeNotifier {
//   int cartCounter = 0;

//   getCount() async {
//     var res = await CartRepository().getCartCount();
//     cartCounter = res.count;
//     notifyListeners();
//   }
// }
import 'dart:async';
import 'dart:developer';

import 'package:MetaBit/repositories/cart_repository.dart';
import 'package:flutter/material.dart';

class CartCounter extends ChangeNotifier {
  int cartCounter = 0;

  Future<void> getCount() async {
    var res = await CartRepository().getCartCount();
    cartCounter = res.count ?? 0;
    log("cart counter${cartCounter.toString()}");
    notifyListeners();
  }
}
