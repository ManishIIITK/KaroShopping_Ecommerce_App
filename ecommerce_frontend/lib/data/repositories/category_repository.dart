import 'package:dio/dio.dart';

import '../../core/api.dart';
import '../models/category/category_model.dart';

class CategoryRepository {
  final _api = Api();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // if successfull then convert raw data to model
      return (apiResponse.data as List<dynamic>).map( (json) => CategoryModel.fromJson(json)).toList();
    } catch (err) {
      rethrow;
    }
  }
}
