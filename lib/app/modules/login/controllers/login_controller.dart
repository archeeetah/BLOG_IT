import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginWithEmail() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter email and password",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoading.value = false;

      Get.snackbar("Success", "Login successful!",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/home');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> loginWithGoogle() async {
    Get.snackbar("Google Login", "Google Login Under Development",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue, colorText: Colors.white);
  }

  void loginWithPhone() {
    Get.snackbar("Coming Soon", "Phone login feature is under development",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue, colorText: Colors.white);
  }
}
