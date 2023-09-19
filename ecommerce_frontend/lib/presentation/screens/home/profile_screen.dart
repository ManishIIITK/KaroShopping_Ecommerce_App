import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/user/user_models.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/screens/order/my_orders_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/linkButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }

        return const Center(
          child: Text("An error occured!!"),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${userModel.fullName}", style: TextStyles.heading3),
            Text(
              "${userModel.email}",
              style: TextStyles.body2,
            ),
            LinkButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              text: "Edit Profile",
            )
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, MyOrderScreen.routeName);
          },
          leading: const Icon(CupertinoIcons.cube_box_fill),
          title: Text(
            "My Order",
            style: TextStyles.body1,
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          leading: const Icon(Icons.exit_to_app_rounded),
          title: Text(
            "Sign Out",
            style: TextStyles.body1.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
