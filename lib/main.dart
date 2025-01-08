import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x_doctor_app/utils/routes/app_pages.dart';
import 'package:smile_x_doctor_app/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: AppPages.pages,
    );
  }
}
