import "package:ecommerce_frontend/core/ui.dart";
import "package:ecommerce_frontend/data/models/user/user_models.dart";
import "package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart";
import "package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart";
import "package:ecommerce_frontend/presentation/widgets/primary_button.dart";
import "package:ecommerce_frontend/presentation/widgets/primary_textField.dart";
import "package:ecommerce_frontend/presentation/widgets/sized_box.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
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
              return editProfile(state.userModel);
            }

            return const Center(
              child: Text("An error occured!!"),
            );
          },
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Personal Details",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold)),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
            initialValue: userModel.fullName,
            onChanged: (value) {
              userModel.fullName = value;
            },
            labelText: "Full Name"),
        const Gap(),
        PrimaryTextField(
            initialValue: userModel.phoneNumber,
            onChanged: (value) {
              userModel.phoneNumber = value;
            },
            labelText: "Phone Number"),
        const Gap(
          size: 20,
        ),
        Text("Address",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold)),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
            initialValue: userModel.address,
            onChanged: (value) {
              userModel.address = value;
            },
            labelText: "Address"),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
            initialValue: userModel.city,
            onChanged: (value) {
              userModel.city = value;
            },
            labelText: "City"),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
            initialValue: userModel.state,
            onChanged: (value) {
              userModel.state = value;
            },
            labelText: "State"),
        const Gap(
          size: -10,
        ),
        PrimaryButton(
          onPressed: () async {
            bool success =
                await BlocProvider.of<UserCubit>(context).updateUser(userModel);
            if (success) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          text: "Save",
        )
      ],
    );
  }
}
 