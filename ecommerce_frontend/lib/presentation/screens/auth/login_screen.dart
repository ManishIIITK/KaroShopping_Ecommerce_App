import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/splash/splash_sreen.dart';
import 'package:ecommerce_frontend/presentation/widgets/linkButton.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_textField.dart';
import 'package:ecommerce_frontend/presentation/widgets/sized_box.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (cotext, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar( 
          // backgroundColor: Colors.red[200],
          centerTitle: true,
          elevation: 0,
          title: const Text("KaroShopping"),
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("Log In", style: TextStyles.heading2),
              const Gap(
                size: -6,
              ),
              (provider.error != "")
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const Gap(),
              const Gap(
                size: 5,
              ),
              PrimaryTextField(
                controller: provider.emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email address is required";
                  }
                  if (!EmailValidator.validate(value.trim())) {
                    return "Invalid email address";
                  }
                  return null;
                },
                labelText: "Email Addess",
              ),
              const Gap(),
              PrimaryTextField(
                controller: provider.passwordController,
                labelText: "Password",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                obscureText: true,
              ),
              LinkButton(
                text: "Forgot Password ?",
                onPressed: () {},
              ),
              const Gap(),
              PrimaryButton(
                  onPressed: provider.logIn,
                  text: (provider.isLoading) ? "..." : "Log In"),
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have an Account",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Gap(),
                  LinkButton(
                    text: "Sign Up",
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
