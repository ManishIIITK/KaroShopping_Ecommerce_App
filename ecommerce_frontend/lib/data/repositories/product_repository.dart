import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';

import '../../core/api.dart';

class ProductRepository {
  final _api = Api();

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductByCategory(String categoryId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$categoryId");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
