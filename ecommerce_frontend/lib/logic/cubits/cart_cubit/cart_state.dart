import 'package:ecommerce_frontend/data/models/cart/cart_item_models.dart';

abstract class CartState {
  final List<CartItemModel> items;
  CartState(this.items);
}

class CartInitialState extends CartState {
  CartInitialState() : super([]);
}

class CartLoadingSate extends CartState {
  CartLoadingSate(super.items);
}
class CartLoadedState extends CartState {
  CartLoadedState(super.items);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message, super.items);
}
