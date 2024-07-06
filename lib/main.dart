import 'package:ctt/view/screens/athentications/login_screen.dart';
import 'package:ctt/view/screens/athentications/sign_up_screen.dart';
import 'package:ctt/view/screens/athentications/verification_screen.dart';
import 'package:ctt/view/screens/coordinator_panel/coordinator_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          initialRoute: '/LoginScreen', // Set the initial route
          getPages: [
            GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
            GetPage(name: '/SignUpScreen', page: () => const SignUpScreen()),
            GetPage(name: '/VerificationScreen', page: () => const VerificationScreen()),
            GetPage(name: '/CoordinatorPanel', page: () => const CoordinatorPanel()),
          ],
        );
      },
    );
  }
}
