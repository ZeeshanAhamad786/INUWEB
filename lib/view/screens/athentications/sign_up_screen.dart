import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ctt/controllers/utils/constant.dart';
import 'package:ctt/controllers/utils/my_color.dart';
import 'package:ctt/view/screens/athentications/login_screen.dart';
import 'package:ctt/view/screens/athentications/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/image_picker_controller.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 4.h, bottom: 4.h, left: 14.w, right: 7.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/png/inuLogo.png", width: 32.w, height: 30.h),
                  Container(
                    width: 38.w,
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Text("Register", style: Constant.textLogin),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () {
                            imagePickerController.getImage();
                          },
                          child: Stack(
                            children: [
                              Obx(() {
                                if (imagePickerController.imagePath.isNotEmpty) {
                                  return CircleAvatar(
                                    backgroundImage: kIsWeb
                                        ? NetworkImage(imagePickerController.imagePath.value)
                                        : FileImage(File(imagePickerController.imagePath.value)) as ImageProvider,
                                    radius: 60,
                                  );
                                } else {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage("assets/png/profileCtt.png"),
                                    radius: 60,
                                  );
                                }
                              }),
                              Positioned(
                                bottom: 0,
                                right: 0.2,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: MyColor.backgroundProfile,
                                      ),
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child: SvgPicture.asset("assets/svg/cameraProfile.svg"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(hintText: "Enter Full Name"),
                        SizedBox(height: 1.5.h),
                        CustomTextField(hintText: "Enter Email"),
                        SizedBox(height: 1.5.h),
                        CustomTextField(
                          hintText: "Enter Password",
                          suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        ),
                        SizedBox(height: 1.5.h),
                        CustomTextField(
                          hintText: "Enter Password Again",
                          suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        ),
                        SizedBox(height: 1.5.h),
                        Padding(
                          padding: EdgeInsets.only(right: 2.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot Password?", style: Constant.textForgot),
                          ),
                        ),
                        SizedBox(height: 2.2.h),
                        CustomApproveButton(
                          buttonText: "Continue",
                          buttonColor: MyColor.blueColor,
                          onPressed: () {
                            Get.to(() => const VerificationScreen());
                          },
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text("Don’t have an account yet?", style: Constant.textGreySign),
                            ),
                            SizedBox(width: 0.5.w),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/login');

                                  // Get.to(() => const LoginScreen());
                                },
                                child: Text("Sign In", style: Constant.textBlueSign),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(width: 3.h),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
