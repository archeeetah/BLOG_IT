import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.9,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.08),

                    // Welcome Text
                    Text(
                      "Welcome to\nBLOG IT.",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Name Field
                    TextField(
                      controller: signupController.nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email Field
                    TextField(
                      controller: signupController.emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Password Field
                    TextField(
                      controller: signupController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Signup Button
                    Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signupController.isLoading.value
                            ? null
                            : signupController.signup,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                        ),
                        child: signupController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text("Signup",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
                    SizedBox(height: screenHeight * 0.03),

                    Text("Or sign up using", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: screenHeight * 0.02),

                    // Social Signup Buttons
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: [
                          IconButton(
                            icon: Image.asset("/Users/architabansal/Desktop/zylentrix_blog/assets/images/logo.png"),
                            iconSize: screenWidth * 0.08,
                            onPressed: signupController.signupWithGoogle,
                          ),
                          IconButton(
                            icon: Icon(Icons.phone,
                                size: screenWidth * 0.12, color: Colors.black),
                            onPressed: signupController.signupWithPhone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Already have an account? Login
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: Text("Already have an account? Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.045)),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
