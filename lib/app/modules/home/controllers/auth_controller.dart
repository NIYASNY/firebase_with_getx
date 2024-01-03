import 'package:firebase_with_getx_todo/app/modules/home/views/home_view.dart';
import 'package:firebase_with_getx_todo/app/modules/home/views/loginscreen.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final Rx<User?> _user = Rx<User?>(firebaseAuth.currentUser);
  User? get user => _user.value;
  final Rx<bool> _isAuthenticating = Rx<bool>(false);
  bool get isAuthenticating => _isAuthenticating.value;
  @override
  void onReady() {
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, onAuthStateChanged);
    super.onReady();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isAuthenticating.value = true;
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _isAuthenticating.value = false;
      return true;
    } catch (e) {
      _isAuthenticating..value = false;
      print('$e');
      return false; 
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      _isAuthenticating.value = true;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      _isAuthenticating.value = false;
      return true;
    } catch (e) {
      _isAuthenticating.value = false;
      print('$e');
      return false;
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  onAuthStateChanged(User? userx) {
    if (userx == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
}
