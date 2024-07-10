import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ctt/controllers/utils/constant.dart';
import 'package:ctt/controllers/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/image_picker_controller.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  SignUpController signUpController =Get.put(SignUpController());

  @override
  void dispose() {
    imagePickerController.dispose();
    super.dispose();
  }

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
                            if (mounted) {
                              imagePickerController.getImage();
                            }
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
                                  return const CircleAvatar(
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
                        CustomTextField(
                          hintText: "Enter Full Name",
                          controller:signUpController.userNameController,
                        ),
                        SizedBox(height: 1.5.h),
                        CustomTextField(
                          hintText: "Enter Email",
                          controller: signUpController.userEmailController,
                        ),
                        SizedBox(height: 1.5.h),
                        CustomTextField(
                          hintText: "Enter Password",
                          isPassword: true,
                          suffixIcon: const Icon(Icons.remove_red_eye_sharp),
                          controller: signUpController.passwordController,
                        ),
                        SizedBox(height: 1.5.h),
                        CustomTextField(
                          hintText: "Enter Password Again",
                          isPassword: true,
                          suffixIcon: const Icon(Icons.remove_red_eye_sharp),
                          controller: signUpController.confirmPasswordController,
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
                    Obx(() =>
                        signUpController.isLoading.value?const Center(child: CircularProgressIndicator(
                          color: MyColor.blueColor,
                        )):
                        CustomApproveButton(
                      buttonText: "Continue",
                      buttonColor: MyColor.blueColor,
                      onPressed: ()  {
                             signUpController.signUp(context);
                      },
                    ),),
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
                                  if (mounted) {
                                    Get.toNamed('/LoginScreen');
                                  }
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
