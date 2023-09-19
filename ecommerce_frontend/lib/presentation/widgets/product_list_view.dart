import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/logic/services/formatter.dart';
import 'package:ecommerce_frontend/presentation/screens/product/product_detail_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/sized_box.dart';
import 'package:flutter/cupertino.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 4,
                imageUrl: "${product.images?[0]}",
              ),
              const Gap(),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}",
                      style: TextStyles.body1
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product.description}",
                      style:
                          TextStyles.body2.copyWith(color: AppColors.textLight),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(),
                    Text(
                      Formatter.formatPrice(product.price!),
                      style: TextStyles.heading3,
                    )
                  ],
                ),
              ),
              // This icon will be visible in the user feed screen besides the product
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(CupertinoIcons.cart_badge_plus),
              // )
            ],
          ),
        );
      },
    );
  }
}
