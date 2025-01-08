import 'package:get/get.dart';
import 'package:smile_x_doctor_app/view/authentication/login.dart';
import 'package:smile_x_doctor_app/view/authentication/signup.dart';
import 'package:smile_x_doctor_app/view/casesubmission.dart';
import 'package:smile_x_doctor_app/view/profile/account.dart';
import 'package:smile_x_doctor_app/view/profile/profile.dart';
import '../../view/home_screen.dart';
import '../../view/splash_screen.dart';
import '../../view/appointment.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.appointment,
      page: () => const AppointmentScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.caseSubmission,
      page: () => const CaseSubmission(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const Profile(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => AccountScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
