import 'package:algoocean/features/bookmark/controller/bookmark_controller.dart';
import 'package:algoocean/features/home/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final bookmarkController = Get.find<BookmarkController>();
  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ),
            ),

            const SizedBox(height: 12),

            // Name
            Text(
              'Omprakash Ranjan',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Email
            Text(
              'omranjan@example.com',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 4),

            // Bio
            Text(
              'Mobile App Developer',
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 16),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to edit profile
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => _buildStat(
                        "Bookmarks",
                        bookmarkController.bookmarks.length.toString(),
                        theme,
                      )),
                  Obx(() => _buildStat(
                        "Articles",
                        newsController.newsList.length.toString(),
                        theme,
                      )),
                  _buildStat("Followers", "980", theme), // Static
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Settings and Logout
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text("Toggle Theme"),
              onTap: () {
                final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
                Get.changeThemeMode(newTheme);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Implement logout logic
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String count, ThemeData theme) {
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
