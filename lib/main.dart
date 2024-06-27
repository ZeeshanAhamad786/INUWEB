import 'package:ctt/view/screens/athentications/login_screen.dart';
import 'package:ctt/view/screens/athentications/sign_up_screen.dart';
import 'package:ctt/view/screens/coordinator_panel/coordinator_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(MyApp());
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
          initialRoute: '/signUp',
          getPages: [
            GetPage(name: '/', page: () => const SignUpScreen()),
            GetPage(name: '/login', page: () => const LoginScreen()),
            GetPage(name: '/coordinatorPanel', page: () => const CoordinatorPanel()),
          ],
        );
      },
    );
  }
}
