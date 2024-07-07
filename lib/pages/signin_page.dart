import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/constants.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text("Sign In to your Account", style: mainHeadingStyle),
              const SizedBox(height: 10),
              CustomTextField(
                heading: 'Email',
                icon: Icons.email,
                hintText: 'Enter your email',
                controller: emailController,
              ),
              CustomTextField(
                heading: 'Password',
                icon: Icons.key,
                isPassword: true,
                hintText: 'Enter your password',
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/forget-password');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Sign In',
                onTap: () {
                  // Handle sign in logic here
                  Get.toNamed("/homepage");
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an Account? "),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
