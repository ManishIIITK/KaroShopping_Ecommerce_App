import 'package:ecommerce_frontend/data/models/category/category_model.dart';

abstract class CategoryState {
  final List<CategoryModel> categories;
  CategoryState(this.categories);
}

class CatergoryInitialState extends CategoryState {
  CatergoryInitialState() : super([]);
}

class CatergoryLoadingState extends CategoryState {
  CatergoryLoadingState(super.categories);
}

class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(super.categories);
}

class CategoryErrorState extends CategoryState {
  final String message;
  CategoryErrorState(this.message, super.categories);
}
