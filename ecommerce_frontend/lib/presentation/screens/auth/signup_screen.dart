import 'package:ecommerce_frontend/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/linkButton.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textField.dart';
import '../../widgets/sized_box.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
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
            Text("Sign Up", style: TextStyles.heading2),
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
            const Gap(),
            PrimaryTextField(
              controller: provider.confirmPasswordController,
              labelText: "Confirm Password",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Confirm your password !";
                }
                if (value.trim() != provider.passwordController.text.trim()) {
                  return "Passwords do not match";
                }
                return null;
              },
              obscureText: true,
            ),
            const Gap(),
            PrimaryButton(
                onPressed: provider.signUp,
                text: (provider.isLoading) ? "..." : "Sign Up"),
            const Gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already Have an Account",
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(),
                LinkButton(
                  text: "Log In",
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
