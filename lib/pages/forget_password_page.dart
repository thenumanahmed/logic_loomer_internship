import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/constants.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ForgetPasswordPage({super.key});

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
              const Text("Forgot Password?", style: mainHeadingStyle),
              const SizedBox(height: 10),
              CustomTextField(
                heading: 'Email',
                icon: Icons.email,
                hintText: 'Enter your email',
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Reset Password',
                onTap: () {
                  // Handle sign in logic here
                  Get.toNamed("/");
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Back to "),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed('/');
                    },
                    child: Text(
                      "Sign In",
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
