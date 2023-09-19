import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/data/models/user/user_models.dart';

import '../../core/api.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({"email": email, "password": password}));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } 
    catch (err) {
      rethrow;
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } 
    catch (err) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest.put("/user/${userModel.sId}",
          data: jsonEncode(userModel.toJson()));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    }  
    catch (err) {
      rethrow;
    }
  }
}
