import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zylentrix_blog/app/modules/signUp/views/sign_up_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get device width
    double screenHeight = MediaQuery.of(context).size.height; // Get device height

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08), // Dynamic padding
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.9, // Max width 90% of the screen
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Text(
                      "BLOG IT.",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08, // Dynamic text size
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Personal Blogging Partner",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Email Field
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: authController.emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Password Field
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: authController.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Login Button
                    Obx(() => authController.isLoading.value
                        ? CircularProgressIndicator()
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authController.loginWithEmail,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
                    SizedBox(height: screenHeight * 0.03),

                    const Text("Or login using", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: screenHeight * 0.02),

                    // Social Login Buttons
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: [
                          IconButton(
                            icon: Image.asset("/Users/architabansal/Desktop/zylentrix_blog/assets/images/logo.png"),
                            iconSize: screenWidth * 0.08,
                            onPressed: authController.loginWithGoogle,
                          ),
                          IconButton(
                            icon: Icon(Icons.phone,
                                size: screenWidth * 0.12, color: Colors.black),
                            onPressed: authController.loginWithPhone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Register Button
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignupView());
                      },
                      child: Text("New here? Register",
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
