import 'dart:async';

import 'package:ecommerce_frontend/data/models/order/order_model.dart';
import 'package:ecommerce_frontend/data/repositories/order_repository.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce_frontend/logic/services/calculations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cart/cart_item_models.dart';
import '../user_cubit/user_cubit.dart';
import '../user_cubit/user_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    _handleUserState(_userCubit.state);

    // listen to user cubit(for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (err) {
      emit(OrderErrorState(err.toString(), state.orders));
    }
  }

  Future<OrderModel?> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return null;
      }
      OrderModel newOrder = OrderModel(
          items: items,
          totalAmount: Calculations.cartTotal(items),
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == "pay-on-deliervery")
              ? "order-placed"
              : "payment-pending");
      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [order, ...state.orders];

      emit(OrderLoadedState(orders));
      // clear the cart when order is placed
      _cartCubit.clearCart();

      return order;
    } catch (err) {
      emit(OrderErrorState(err.toString(), state.orders));
      return null;
    }
  }

  Future<bool> updateOrder(OrderModel orderModel,
      {String? paymentId, String? signature}) async {
    try {
      OrderModel updatedOrder = await _orderRepository.updateOrder(orderModel,
          paymentId: paymentId, signature: signature);

      int index = state.orders.indexOf(updatedOrder);
      if (index == -1) return false;

      List<OrderModel> newList = state.orders;
      newList[index] = updatedOrder;

      emit(OrderLoadedState(newList));
      return true;
    } catch (err) {
      emit(OrderErrorState(err.toString(), state.orders));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
