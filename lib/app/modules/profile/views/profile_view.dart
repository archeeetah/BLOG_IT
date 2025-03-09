import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
        style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.indigo[100],
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: controller.pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: controller.selectedImage.value != null
                    ? FileImage(controller.selectedImage.value!)
                    : (controller.imageUrl.value.isNotEmpty
                    ? NetworkImage(controller.imageUrl.value)
                as ImageProvider
                    : AssetImage("/Users/architabansal/Desktop/zylentrix_blog/assets/images/img.png")),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: controller.pickImage,
              child: Text("Change Profile Picture",
                  style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.emailController,
              readOnly: true, // Email is not editable
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[200],
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Save Changes",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      )),
    );
  }
}
