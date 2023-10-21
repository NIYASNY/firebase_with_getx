import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_with_getx_todo/app/widgets/todo_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    controller: emailcontroller,
                    validator: (value) {
                      if (!regExForEmail.hasMatch(value!)) {
                        return 'Please enter vallid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('Email')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passcontroller,
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Minimum 8 Characters required';
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
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : MaterialButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey.currentState!.validate()) {
                                  print('ok');
                                  final result = await authcontroller.register(
                                      emailcontroller.text,
                                      passcontroller.text);
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
                                  print('Not Ok');
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ));
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Text('Already have an account'),
                      TextButton(
                          onPressed: () {
                            Get.off(() => const LoginScreen());
                          },
                          child: const Text('Login now'))
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
