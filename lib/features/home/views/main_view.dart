import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import '../../bookmark/views/bookmark_view.dart';
import '../../profile/views/profile_view.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeView(),
    // ExploreView(),
    BookmarkView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              // BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            selectedItemColor: Theme.of(context).highlightColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}
