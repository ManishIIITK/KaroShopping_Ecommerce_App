import "package:ecommerce_frontend/core/ui.dart";
import "package:ecommerce_frontend/presentation/widgets/sized_box.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  static const routeName = "order_placed";

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
      ),
      body:Center(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.cube_box_fill,
                size: 100, color: AppColors.textLight,
              ),
              const Gap(size: -5),
              Text(
                "Order Placed",
                style: TextStyles.heading3.copyWith(color: AppColors.textLight),
              ),
              const Gap(size: -10),
              Text("Thank You for shopping with", style: TextStyles.body1,),
              const Gap(size: -5),
              Text("KaroShopping",style: TextStyles.heading1,)
              
            ],
          ),
      ),
      ),
    );
  }
}
