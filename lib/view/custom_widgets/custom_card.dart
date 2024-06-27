import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controllers/utils/constant.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String number;
  final String imagePath;

  const CustomCard({
    Key? key,
    required this.title,
    required this.number,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: 14.w,
      padding: EdgeInsets.symmetric( vertical: 0.8.w),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 8, // Blur radius
            offset: Offset(1, 1), // Shadow position (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Text(
                  title,
                  style: Constant.textTeacher,
                  textAlign: TextAlign.center,
                ),
                Text(
                  number,
                  style: Constant.textTeacherNumber,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(width: 0.6.w), // You can replace this with your custom method if needed
          Flexible(
            flex: 1,
            child: Image.asset(
              imagePath,
              height: 12.h,
              width: 12.w,
            ),
          ),
        ],
      ),
    );
  }
}
