import 'package:flutter/foundation.dart';

class OrderDetailProvider with ChangeNotifier {
  String? paymentMethod = "pay-now";

  void changePaymentMethod(String? value) {
    paymentMethod = value;
    notifyListeners();
  }
}
