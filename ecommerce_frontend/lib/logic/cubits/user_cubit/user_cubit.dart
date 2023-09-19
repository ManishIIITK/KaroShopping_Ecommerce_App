// ignore: file_names
import 'package:ecommerce_frontend/data/models/user/user_models.dart';
import 'package:ecommerce_frontend/data/repositories/user_repositories.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _intialize();
  }
  final UserRepository _userRepository = UserRepository();

  void _intialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];

    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (err) {
      emit(UserErrorState(err.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (err) {
      emit(UserErrorState(err.toString()));
    }
  }

  Future<bool> updateUser(UserModel userModel) async {
    emit(UserLoadingState());
    try {
      UserModel updatedUser = await _userRepository.updateUser(userModel);
      emit(UserLoggedInState(updatedUser));
      return true;
    } catch (err) {
      emit(UserErrorState(err.toString()));
      return false;
    }
  }

  void signOut() async {
    await Preferences.clear();
    emit(UserLoggedOutState());
  }
}
