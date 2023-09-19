import 'package:ecommerce_frontend/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initalize();
  }

  final _productRepository = ProductRepository();

  void _initalize() async {
    emit(ProductLoadingState(state.products));
    try {
      final products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (err) {
      emit(ProductErrorState(err.toString(), state.products));
    }
  }
} 
