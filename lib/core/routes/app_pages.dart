import 'package:algoocean/features/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../../features/home/views/main_view.dart';

class AppRoutes {
  static const INITIAL = '/splash';
  static const HOME = '/home';
}

final List<GetPage> appPages = [
  GetPage(
    name: AppRoutes.INITIAL,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.HOME,
    page: () => MainView(),
  ),

];
