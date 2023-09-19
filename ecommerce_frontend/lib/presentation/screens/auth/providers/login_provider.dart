import 'dart:async';

import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    // log("Listening to user cubit");
    // ignore: avoid_types_as_parameter_names
    _userSubscription =
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        BlocProvider.of<UserCubit>(context).stream.listen((UserState) {
      if (UserState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (UserState is UserErrorState) {
        isLoading = false;
        error = UserState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void logIn() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
