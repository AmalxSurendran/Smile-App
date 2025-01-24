import 'package:get/get.dart';
import 'package:smile_x_doctor_app/view/add_appointment.dart';
import 'package:smile_x_doctor_app/view/authentication/login.dart';
import 'package:smile_x_doctor_app/view/authentication/signup.dart';
import 'package:smile_x_doctor_app/view/casesubmission.dart';
import 'package:smile_x_doctor_app/view/profile/account.dart';
import 'package:smile_x_doctor_app/view/profile/add_clinic.dart';
import 'package:smile_x_doctor_app/view/profile/profile.dart';
import '../../controller/clinic_controller.dart';
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
      binding: BindingsBuilder(() => Get.lazyPut(() => ClinicController())),
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
      page: () => const AccountScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.AddClinic,
      page: () => const AddClinic(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.AddAppointment,
      page: () => const AddAppointment(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
