import 'package:ctt/controllers/utils/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class CustomTextField extends StatelessWidget {
  final String hintText;
  // final Widget?  prefixIcon;
  final Widget?  suffixIcon;
  // final TextEditingController controller;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    // this.prefixIcon,
    this.suffixIcon,
    // required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        obscureText: obscureText,
        cursorColor: MyColor.greyColor, // Replace with your CustomColor.mainColor
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 12.px,
        fontWeight: FontWeight.w600,
              color:MyColor.greyColor// Replace with your CustomColor.mainEmailIconGreyColor
          ),
          contentPadding: EdgeInsets.all(10),
          // prefixIcon: Transform.scale(
          //   scale: 0.4,
          //   child: prefixIcon,
          //
          // ),
          suffixIcon: suffixIcon,
          // isDense: true,

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColor.greyBorderColor,),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColor.greyBorderColor,),
          ),
        ),
      );
  }
}

//

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsets contentPadding;

  const CustomTextFormField({
    Key? key,
    this.hintText = '',
    this.controller,
    this.keyboardType,
    this.hintStyle,
    this.fillColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderRadius = 14.0,
    this.contentPadding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
        isDense: true,
        isCollapsed: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

//

class CustomTextFormFieldLine extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextStyle hintStyle;
  final Color fillColor;
  final Color borderColor;

  const CustomTextFormFieldLine({
    Key? key,
    this.maxLines = 1,
    required this.hintText,
    required this.hintStyle,
    required this.fillColor,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

///

class CustomSearchTextField extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final Function(String)? onChanged;

  const CustomSearchTextField({
    Key? key,
    required this.hintText,
    required this.hintStyle,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: MyColor.blueColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        isCollapsed: true,
        contentPadding: EdgeInsets.all(10),
        prefixIcon: Transform.scale(
          scale: 0.5,
          child: SvgPicture.asset("assets/svg/search.svg"),
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: MyColor.blueColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: MyColor.blueColor),
        ),
      ),
      onChanged: onChanged,
    );
  }
}





