import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService extends GetxController {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  RxList posts = [].obs; // Changed to observable list
  RxBool isLoading = false.obs; // Added loading state

  // Fungsi untuk GET data
  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        posts.value = json.decode(response.body);
        Get.snackbar(
          'Success',
          'Data berhasil diambil!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load posts: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk POST data
  Future<void> createPost() async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'Flutter Post',
          'body': 'Ini contoh POST.',
          'userId': 1,
        }),
      );
      if (response.statusCode == 201) {
        posts.add({
          'title': 'Flutter Post',
          'body': 'Ini contoh POST.',
          'id': posts.length + 1,
        });
        Get.snackbar(
          'Success',
          'Data berhasil ditambahkan!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk UPDATE data
  Future<void> updatePost() async {
    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse('$baseUrl/posts/1'),
        body: json.encode({
          'title': 'Updated Title',
          'body': 'Updated Body',
          'userId': 1,
        }),
      );
      if (response.statusCode == 200) {
        final index = posts.indexWhere((post) => post['id'] == 1);
        if (index != -1) {
          posts[index] = {
            ...posts[index],
            'title': 'Updated Title',
            'body': 'Updated Body',
          };
        }
        Get.snackbar(
          'Success',
          'Data berhasil diperbarui!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk DELETE data
  Future<void> deletePost() async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/1'),
      );
      if (response.statusCode == 200) {
        posts.removeWhere((post) => post['id'] == 1);
        Get.snackbar(
          'Success',
          'Data berhasil dihapus!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
