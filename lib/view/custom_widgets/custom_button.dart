import 'package:ctt/controllers/utils/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/utils/constant.dart';
class CustomMainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;

  // final  RxBool? loading;

  CustomMainButton({
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    // this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        fixedSize: Size( MediaQuery.of(context).size.width, 6.h),
        backgroundColor: buttonColor,

        // Text color
      ),
      child: Text(buttonText,
          textAlign: TextAlign.center,
          style:  Constant.textButton,

      ),
    );
  }
}









class CustomApproveButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? buttonColor;
  final Color? disabledColor; // Color when button is disabled


  // final  RxBool? loading;

  CustomApproveButton({
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
     this.disabledColor, // Initialize disabledColor

    // this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        fixedSize: Size( MediaQuery.of(context).size.width, 6.h),
        backgroundColor: onPressed != null ? buttonColor : disabledColor,

        // Text color
      ),
      child: Text(buttonText,
        textAlign: TextAlign.center,
        style:  Constant.textButton,

      ),
    );
  }
}




//3rd button
class CustomTaskButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? buttonColor;

  const CustomTaskButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: buttonColor ,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Constant.textButton.copyWith(
              color: Colors.white // Adjust text color based on button state
            ),
          ),
        ),
      ),
    );
  }
}


//4rth
class CustomSatisfactoryButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? buttonColor;


  const CustomSatisfactoryButton({super.key,
    required this.buttonText,
     this.onPressed,
    this.buttonColor,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.5.w,vertical: 1.h),
        decoration: BoxDecoration(
          color:buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Constant.textButton.copyWith(
              color:  Colors.white , // Adjust text color based on button state
            ),
          ),
        ),
      ),
    );
  }
}








Widget getHorizontal(double width){
  return SizedBox(width: width,);
}
    Widget getVertical(double height){
  return SizedBox(height: height,);
    }