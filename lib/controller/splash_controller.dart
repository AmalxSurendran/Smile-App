import 'package:get/get.dart';
import '../utils/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToInitialScreen();
  }

  void navigateToInitialScreen() {
    Future.delayed(const Duration(milliseconds: 4500), () {
      Get.offNamed(AppRoutes.login);
    });
  }
}
