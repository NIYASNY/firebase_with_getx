import 'package:firebase_with_getx_todo/app/modules/home/controllers/auth_controller.dart';
import 'package:firebase_with_getx_todo/app/widgets/todo_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.put(AuthController());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TodoLogo(),
            Padding(padding:  EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              child: LinearProgressIndicator(),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
