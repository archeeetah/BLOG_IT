import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> blog = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[100],
        title: Text("Blog Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog['title'] ?? "No Title",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "User ID: ${blog['userId']?.toString() ?? "Unknown"}",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  blog['body'] ?? "No Content",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
