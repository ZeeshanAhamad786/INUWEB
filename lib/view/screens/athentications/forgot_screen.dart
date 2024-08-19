import 'package:ctt/controllers/utils/constant.dart';
import 'package:ctt/controllers/utils/my_color.dart';
import 'package:ctt/view/custom_widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/forgot_password_controller.dart';
import '../../custom_widgets/custom_button.dart';
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ForgotPasswordController forgotPasswordController =Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MyColor.blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 5.h,left: 14.w,right: 7.h),
          child: Column(children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Image.asset("assets/png/inuLogo.png",width: 32.w,height: 30.h,)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                    child: Column(
                      children: [
                        getVertical(4.h),
                        Text("Forgot Password",style: Constant.textLogin,),
                        getVertical(2.h),
                         Text("Please enter your registered mail address",style: Constant.textTeacherNumber,),
                        getVertical(2.h),
                        Image.asset("assets/png/loginImage.png",height: 200.px,width: 20.w,),
                        getVertical(2.h),
                        CustomTextField(hintText: "Enter Email", controller: forgotPasswordController.emailController,),
                        getVertical(2.2.h),
                     Obx(() =>    forgotPasswordController.isLoading.value?const Center(child: CircularProgressIndicator(color: MyColor.blueColor,))
                         :   CustomApproveButton(buttonText: "Done",buttonColor: MyColor.blueColor,
                         onPressed: (){
                           forgotPasswordController.forgotPassword(context);
                           // Get.offAllNamed('/CoordinatorPanel');
                           // Get.offAll(()=>const CoordinatorPanel());
                         }),),
                        getVertical(6.h),getHorizontal(6.h)
                      ],
                    ),
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
