import 'package:ctt/controllers/utils/constant.dart';
import 'package:ctt/controllers/utils/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../custom_widgets/custom_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MyColor.blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: 7.h,bottom: 7.h,left: 14.w,right: 7.h),
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
                      Text("Verification",style: Constant.textLogin,),
                      getVertical(2.h),
                      Image.asset("assets/png/verificationWeb.png",width: 50.w,height: 300,),

                      getVertical(5.h),
                     Text("""Your Registration Info has been sent\n to authorities when they approve, you\n will be able to use the portal""",
                     style:Constant.textBlackShine ,
                     ),
                      getVertical(6.h),getHorizontal(6.h)
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
