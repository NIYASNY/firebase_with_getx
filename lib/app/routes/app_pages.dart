import 'package:firebase_with_getx_todo/app/modules/home/views/welcome_screen.dart';
import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const WelcomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
