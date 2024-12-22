import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prak_14/service/api_service.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final ApiService apiService = Get.put(ApiService()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              // Observe changes in loading and posts
              if (apiService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (apiService.posts.isEmpty) {
                return const Text(
                  "Tekan tombol GET untuk mengambil data",
                  style: TextStyle(fontSize: 12),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: apiService.posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            apiService.posts[index]['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            apiService.posts[index]['body'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            ElevatedButton(
              onPressed: () => apiService.fetchPosts(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('GET'),
            ),
            ElevatedButton(
              onPressed: () => apiService.createPost(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('POST'),
            ),
            ElevatedButton(
              onPressed: () => apiService.updatePost(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('UPDATE'),
            ),
            ElevatedButton(
              onPressed: () => apiService.deletePost(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('DELETE'),
            ),
          ],
        ),
      ),
    );
  }
}
