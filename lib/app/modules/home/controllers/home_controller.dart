import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var blogs = <Map<String, dynamic>>[].obs; // List of blogs
  var isLoading = false.obs; // Loading state
  var hasMore = true.obs; // To track if more data is available
  int page = 1; // Current page number

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchBlogs(); // Fetch initial blogs
    scrollController.addListener(_scrollListener); // Listen for scrolling
    super.onInit();
  }

  Future<void> fetchBlogs() async {
    if (!hasMore.value || isLoading.value) return;
    isLoading(true);
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10"))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        if (data.isEmpty) {
          hasMore(false); // No more blogs to load
        } else {
          blogs.addAll(
            data.map((blog) => {"title": blog['title'],
              "body": blog['body'], // Store the full blog content
            }).toList(),
          );
          page++; // Increase page number for next fetch
        }
      } else {
        Get.snackbar("Error", "Failed to load blogs");
      }
    } catch (e) {
      Get.snackbar("Error", "Network Issue or API Timeout");
    } finally {
      isLoading(false);
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchBlogs(); // Fetch more blogs when scrolled to bottom
    }
  }
}
