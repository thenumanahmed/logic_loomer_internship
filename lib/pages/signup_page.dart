import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/constants.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

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
              const Text("Create An Account", style: mainHeadingStyle),
              const SizedBox(height: 10),
              CustomTextField(
                heading: 'Name',
                icon: Icons.person,
                hintText: 'Enter your name',
                controller: nameController,
              ),
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
              // const SizedBox(height: 16),
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
                text: 'Sign Up',
                onTap: () {
                  // String name = nameController.text;
                  // String email = emailController.text;
                  // String password = passwordController.text;
                  Get.toNamed("/homepage");
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account? "),
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
