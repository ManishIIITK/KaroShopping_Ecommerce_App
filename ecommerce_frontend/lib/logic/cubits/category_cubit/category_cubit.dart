import 'package:ecommerce_frontend/data/models/category/category_model.dart';
import 'package:ecommerce_frontend/data/repositories/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CatergoryInitialState()) {
    _initalize();
  }

  final _categoryRepository = CategoryRepository();

  void _initalize() async {
    emit(CatergoryLoadingState(state.categories));
    try {
      List<CategoryModel> categories =
          await _categoryRepository.fetchAllCategories();
      emit(CategoryLoadedState(categories));
    } catch (err) {
      emit(CategoryErrorState(err.toString(), state.categories));
    }
  }
}
