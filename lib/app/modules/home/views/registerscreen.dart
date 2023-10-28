import 'package:firebase_with_getx_todo/app/modules/home/views/loginscreen.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_with_getx_todo/app/widgets/todo_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const TodoLogo(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (!regExForEmail.hasMatch(value!)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Minimum 8 characters required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                  ),
                ),
                Obx(() {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8.0),
                    height: 60,
                    decoration: BoxDecoration(
                      color: authcontroller.isAuthenticating
                          ? PrimaryColor.shade200
                          : PrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: authcontroller.isAuthenticating
                        ? const Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (formKey.currentState!.validate()) {
                                print('Ok');
                                final result = await authcontroller.register(
                                    emailController.text,
                                    passwordController.text);
                                if (!result) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Something went wrong'),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                }
                              } else {
                                print('Not ok');
                              }
                            },
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: const Text('Login Now'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
