import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zylentrix_blog/app/modules/blogDetails/views/blog_details_view.dart';
import 'package:zylentrix_blog/app/modules/login/views/login_view.dart';
import 'package:zylentrix_blog/app/modules/profile/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = "Loading..."; // Default text while fetching data

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? "User"; // Fetching name from FireBase
        });
      } else {
        setState(() {
          userName = "Archita Bansal"; // Fallback if no data found
        });
      }
    } else {
      setState(() {
        userName = "Guest"; // If user is not logged in
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[100],
        title: const Text("BLOG IT.",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("/Users/architabansal/Desktop/zylentrix_blog/assets/images/img.png"),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("/Users/architabansal/Desktop/zylentrix_blog/assets/images/img.png")),
                  SizedBox(height: 10),
                  Text(userName, // Displaying fetched username
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () {
                  Get.to(() => ProfileView());
                }),
            ListTile(
                leading: Icon(Icons.explore),
                title: Text("Explore"),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.add),
                title: Text("Add Blog"),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.book),
                title: Text("My Blog"),
                onTap: () {}),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.to(() => LoginView());
                Get.snackbar("Logout", "You have been logged out successfully",
                    snackPosition: SnackPosition.BOTTOM);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Explore some latest blogs",
                    style: TextStyle(fontSize: 20, color: Colors.purple)),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Fetching blogs... Please wait",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              }

              if (homeController.blogs.isEmpty) {
                return Center(child: Text("No blogs available"));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await homeController.fetchBlogs();
                },
                child: ListView.builder(
                  controller: homeController.scrollController,
                  padding: const EdgeInsets.all(10),
                  itemCount: homeController.blogs.length +
                      (homeController.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == homeController.blogs.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final blog = homeController.blogs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        title: Text(
                          blog['title'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                        onTap: () {
                          Get.to(() => BlogDetailsView(), arguments: {
                            "userId": blog['userId'],
                            "title": blog['title'],
                            "body": blog['body'],
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
