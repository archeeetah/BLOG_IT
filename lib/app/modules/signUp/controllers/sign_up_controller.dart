import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zylentrix_blog/app/data/firebase/firebase_auth.dart';
import 'package:zylentrix_blog/app/data/firebase/firebase_function.dart';
import 'package:zylentrix_blog/app/modules/home/views/home_view.dart';

class SignupController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunction _function = FirebaseFunction();
  var isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signup() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        await _authentication.createAccount(
            emailController.text, passwordController.text);

        await _function.createUserCredential(nameController.text, emailController.text);

        isLoading.value = false;

        Get.snackbar("Success", "Account Created Successfully!",
            snackPosition: SnackPosition.BOTTOM);

        // Navigate to home after showing success message
        Get.to(() => HomePage());
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  void signupWithGoogle() {
    Get.snackbar("Google Signup", "Coming Soon!",
        snackPosition: SnackPosition.BOTTOM);
  }

  void signupWithPhone() {
    Get.snackbar("Phone Signup", "Coming Soon!",
        snackPosition: SnackPosition.BOTTOM);
  }
}
