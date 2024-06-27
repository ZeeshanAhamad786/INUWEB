import 'package:ctt/controllers/utils/constant.dart';
import 'package:ctt/controllers/utils/my_color.dart';
import 'package:ctt/view/custom_widgets/custom_textfield.dart';
import 'package:ctt/view/screens/athentications/sign_up_screen.dart';
import 'package:ctt/view/screens/athentications/verification_screen.dart';
import 'package:ctt/view/screens/coordinator_panel/coordinator_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../custom_widgets/custom_button.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MyColor.blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: 5.h,bottom: 5.h,left: 14.w,right: 7.h),
          child: Column(children: [

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/png/inuLogo.png",width: 32.w,height: 30.h,),
              Container(width: 38.w,
                padding: EdgeInsets.symmetric(horizontal: 9.h),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                child: Column(
                  children: [
                    getVertical(4.h),
                    Text("Login",style: Constant.textLogin,),
                    getVertical(2.h),
                    Image.asset("assets/png/loginImage.png",height: 200.px,width: 20.w,),
                    getVertical(2.h),
                    CustomTextField(hintText: "Enter Email",),
                    getVertical(2.h),
                    CustomTextField(hintText: "Enter Password",suffixIcon: Icon(Icons.remove_red_eye_sharp),),
                    getVertical(1.h),
                    Padding(
                      padding:  EdgeInsets.only(right: 2.h),
                      child: Align(alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",style: Constant.textForgot,)),
                    ),
                    getVertical(2.2.h),
                    CustomApproveButton(buttonText: "Login",buttonColor: MyColor.blueColor,
                        onPressed: (){
                          Get.toNamed('/coordinatorPanel');
                          // Get.to(()=>CoordinatorPanel());
                        }),
                    getVertical(2.h),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: Text("Don’t have an account yet?",style: Constant.textGreySign,)),
                        getHorizontal(.5.w),
                        Flexible(child: GestureDetector(onTap: () {
                          Get.to(()=>SignUpScreen());
                        },
                            child: Text("Sign Up",style: Constant.textBlueSign,))),
                      ],
                    ),
                    getVertical(4.h),getHorizontal(4.h)
                  ],
                ),
              )
            ],
          )
          ],),
        ),
      ),

    );
  }
}
