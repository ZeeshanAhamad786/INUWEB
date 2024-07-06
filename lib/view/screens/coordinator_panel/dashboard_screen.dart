import 'package:ctt/controllers/utils/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/utils/constant.dart';
import '../../../model/notification_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_card.dart';
import '../../custom_widgets/custom_coordinate_name.dart';
import '../athentications/login_screen.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<NotificationModel> data=[
    NotificationModel(imagePath: 'assets/png/notificationProfile.png', title: 'Joe Simt', email: 'abc@xyz.com', text: 'Task “Yesterday topic” status changed to Done',
        dateTime: '01 June 04:30 PM'),
    NotificationModel(imagePath: 'assets/png/notificationProfile.png', title: 'Joe Simt', email: 'abc@xyz.com', text: 'Task “Yesterday topic” status changed to Done',
        dateTime: '01 June 04:30 PM'),
    NotificationModel(imagePath: 'assets/png/notificationProfile.png', title: 'Joe Simt', email: 'abc@xyz.com', text: 'Task “Yesterday topic” status changed to Done',
        dateTime: '01 June 04:30 PM'),
    NotificationModel(imagePath: 'assets/png/notificationProfile.png', title: 'Joe Simt', email: 'abc@xyz.com', text: 'Task “Yesterday topic” status changed to Done',
        dateTime: '01 June 04:30 PM'),
    NotificationModel(imagePath: 'assets/png/notificationProfile.png', title: 'Joe Simt', email: 'abc@xyz.com', text: 'Task “Yesterday topic” status changed to Done',
        dateTime: '01 June 04:30 PM'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCoordinateName(coordinateName: 'Coordinate Name', onLogout: () {
                Get.offAllNamed('/LoginScreen');
              },),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Total Metrices",
                        style: Constant.textTotalMatrices,
                      ),
                    ),
                    getHorizontal(6.w),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Notifications",
                        style: Constant.textTotalMatrices,
                      ),
                    ),
                   // getHorizontal(2.w),
                    const Expanded(child: SizedBox()),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(onTap: () {
                        // Get.to(()=>LoginScreen());
                      },
                        child: Text(
                          "Mark all as read",style:Constant.textMarkRead,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              getVertical(2.h),
              Row(
                children: [
                  Column(
                    children: [
                      CustomCard(title: 'Teachers', number: '10', imagePath: 'assets/png/taskImage.png'),
                      getVertical(2.5.h),
                      CustomCard(title: 'Tasks', number: '10', imagePath: 'assets/png/taskImage.png'),
                      getVertical(2.5.h),
                      CustomCard(title: 'Teacher\nVerification', number: '10', imagePath: 'assets/png/taskImage.png'),
                      getVertical(2.5.h),
                      CustomCard(title: 'Coordinator\nVerification', number: '10', imagePath: 'assets/png/taskImage.png'),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 32.w,
                      margin: EdgeInsets.only(left: 2.w),
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
                      child: Column(
                        children: [
                          SizedBox(height: 4.h),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
                                  padding: EdgeInsets.only(top: 1.5.w, left: 1.w,right: 1.w,bottom: 0.3.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF7F7F7),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(backgroundImage: AssetImage(data[index].imagePath)),
                                      SizedBox(width: 8), // Spacing between avatar and text
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].title,
                                              style: Constant.textTitle,
                                              overflow: TextOverflow.ellipsis, // Handle overflow
                                            ),
                                            Text(
                                              data[index].email,
                                              style: Constant.textEmail,
                                              overflow: TextOverflow.ellipsis, // Handle overflow
                                            ),
                                          ],
                                        ),
                                      ),
                                      getHorizontal(1.w), // Spacing between text columns and notification text
                                      Expanded(
                                        child: Column(crossAxisAlignment:CrossAxisAlignment.end,
                                          children: [
                                            Container(height:10,width:10,
                                              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(20),color: MyColor.redColor),),
                                            Text(
                                              data[index].text,
                                              style: Constant.textNotification,
                                              overflow: TextOverflow.ellipsis, // Handle overflow
                                            ),
                                            Text(data[index].dateTime,style: Constant.textEmail,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
