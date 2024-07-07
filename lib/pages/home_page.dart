import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/constants.dart';
import 'package:internship_task/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Home Page',style: mainHeadingStyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CustomButton(
            onTap: () {
              Get.offAllNamed('/login');
            },
            text: 'Logout',
          ),
        ),
      ),
    );
  }
}
