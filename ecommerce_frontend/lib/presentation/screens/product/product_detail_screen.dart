import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/services/formatter.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  String url = widget.productModel.images![index];
                  return CachedNetworkImage(imageUrl: url);
                },
                itemCount: widget.productModel.images?.length ?? 0,
                options: CarouselOptions(),
              ),
            ),
            const Gap(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.productModel.title}",
                    style: TextStyles.heading3,
                  ),
                  Text(Formatter.formatPrice(widget.productModel.price!),
                      style: TextStyles.heading2),
                  const Gap(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      bool isInCart = BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.productModel);
                      return PrimaryButton(
                        
                        onPressed: () {
                          if (isInCart) {
                            return;
                          }

                          BlocProvider.of<CartCubit>(context)
                              .addToCart(widget.productModel, 1);
                        },
                        color: (isInCart)
                            ? AppColors.textLight
                            : AppColors.accent,
                        text: (isInCart)
                            ? "Go to Cart"
                            : "Add to Cart",
                      );
                    },
                  ),
                  const Gap(),
                  Text(
                    "Description",
                    style:
                        TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
