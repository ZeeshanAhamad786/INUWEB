import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controllers/utils/constant.dart';
import '../../controllers/utils/my_color.dart';
class CustomCoordinateName extends StatelessWidget {
  final String coordinateName;
  final VoidCallback onLogout;

  CustomCoordinateName({
    required this.coordinateName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 4,
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              coordinateName,
              style: Constant.textCoordinateName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onLogout,
            child: Container(
              height: 5.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Logout",
                  style: Constant.textLogout,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class EditTaskComponent extends StatelessWidget {
   final RxBool showDetail,addNewOrEdit;


  const EditTaskComponent({super.key,

    required this.showDetail, required this.addNewOrEdit,
  });

  @override
  Widget build(BuildContext context) {
    return
     Obx(() =>showDetail.value==true?  Container(
       margin: EdgeInsets.symmetric(vertical: 1.w),
       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .6.w),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(24),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.1),
             offset: Offset(0, 4),
             blurRadius: 4,
           )
         ],
         color: Colors.white,
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: Align(alignment:Alignment.centerLeft ,
               child: GestureDetector(onTap:() {
                 showDetail.value=false;
               },
                 child: Container(
                   height: 2.5.w,width: 2.5.w,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: MyColor.backgroundColor),
                   child: Center(child: Icon(Icons.arrow_back,size: 16.px,)),
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: () {
               addNewOrEdit.value=true;
             },
             child: Container(
               height: 35,
               padding: EdgeInsets.symmetric(horizontal: 4.w),
               decoration: BoxDecoration(
                 color: MyColor.blueColor,
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Center(
                 child: Text(
                   "Edit Task",
                   style: Constant.textLogout,
                 ),
               ),
             ),
           ),
         ],
       ),
     ):SizedBox());
  }
}
