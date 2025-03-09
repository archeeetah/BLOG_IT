import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  var isLoading = false.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var imageUrl = "".obs;
  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  // Fetch user profile details from Firestore
  void fetchUserProfile() async {
    isLoading.value = true;
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
      await _firestore.collection("users").doc(uid).get();

      if (userDoc.exists) {
        nameController.text = userDoc["name"];
        emailController.text = userDoc["email"];
        imageUrl.value = userDoc["profileImage"] ?? "";
      }
    } catch (e) {
      // Get.snackbar("Error", "Failed to fetch user details");
    } finally {
      isLoading.value = false;
    }
  }

  // Update user profile details in Firestore
  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection("users").doc(uid).update({
        "name": nameController.text,
        "email": emailController.text,
        "profileImage": imageUrl.value,
      });
      Get.snackbar("Success", "Profile updated successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile");
    } finally {
      isLoading.value = false;
    }
  }

  // Pick an image from gallery and upload to Firebase Storage
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await uploadImage(File(pickedFile.path));
    }
  }

  // Upload image to Firebase Storage and get URL
  Future<void> uploadImage(File image) async {
    try {
      String uid = _auth.currentUser!.uid;
      String fileName = "profile_$uid.jpg";
      Reference storageRef = _storage.ref().child("profileImages/$fileName");

      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      imageUrl.value = downloadUrl;
      Get.snackbar("Success", "Profile image updated!");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image");
    }
  }
}
