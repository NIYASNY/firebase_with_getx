import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_with_getx_todo/app/modules/home/views/welcome_screen.dart';
import 'package:firebase_with_getx_todo/app/widgets/notification.dart';
import 'package:firebase_with_getx_todo/firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications(); 
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    ),
  );
}
