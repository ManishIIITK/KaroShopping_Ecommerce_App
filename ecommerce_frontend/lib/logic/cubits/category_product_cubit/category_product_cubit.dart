import 'package:ecommerce_frontend/data/models/category/category_model.dart';
import 'package:ecommerce_frontend/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products =
          await _productRepository.fetchProductByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (err) {
      emit(CategoryProductErrorState(err.toString(), state.products));
    }
  }
}
