// ignore: file_names
import 'package:ecommerce_frontend/data/models/user/user_models.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

// ignore: camel_case_types
class UserLoadingState extends UserState {}

class UserLoggedInState extends UserState {
  final UserModel userModel;
  UserLoggedInState(this.userModel);
}

class UserLoggedOutState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
