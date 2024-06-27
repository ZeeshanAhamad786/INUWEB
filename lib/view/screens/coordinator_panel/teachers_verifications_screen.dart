import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../../model/teachers_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';
class TeachersVerificationsScreen extends StatefulWidget {

  const TeachersVerificationsScreen({super.key,   });

  @override
  State<TeachersVerificationsScreen> createState() => _TeachersVerificationsScreenState();
}

class _TeachersVerificationsScreenState extends State<TeachersVerificationsScreen> {
  List<TeachersModel> data=[
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "usman", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "usman", userEmail: "abc@xyz.com"),

  ];
  List<TeachersModel> data1=[
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "ramzan", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "rana", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/notificationProfile.png", userName: "ahmad", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "ahmad", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(imageUrl: "assets/png/profile1.png", userName: "usman", userEmail: "abc@xyz.com"),

  ];
  RxBool isTeacher=true.obs;
  RxBool isCoordinate=false.obs;
  @override
  Widget build(BuildContext context) {
    return
    Obx(() =>   Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(children: [
          CustomCoordinateName(coordinateName: 'Coordinate Name', onLogout: () {  },),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:3.h ),

                width: MediaQuery.of(context).size.width,
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
                child:Column(children: [
                  getVertical(2.h),
                  Row(
                    children: [
                      Expanded(flex:2,
                        child: TextFormField(decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Transform.scale(scale: 0.5,
                                child: SvgPicture.asset("assets/svg/search.svg")),
                            hintText: isTeacher.value?"Search Teacher":"Search Coordinator",
                            isDense: true,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color: MyColor.blueColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color:MyColor.blueColor ))),),
                      ),
                      Expanded(flex:1,
                        child: Container(
                          margin: EdgeInsets.only(left: 1.w),
                            padding: EdgeInsets.only(top: 0.46.w,bottom: 0.46.w),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white,border: Border.all(color: MyColor.blueColor)),

                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(onTap:() {
                                    isTeacher.value=true;
                                    isCoordinate.value=false;
                                  },
                                    child: Container(
                                      margin:EdgeInsets.symmetric(horizontal: 0.5.w),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isTeacher.value?MyColor.blueColor:Colors.white),
                                      child: Center(child:  Text("Teachers",style: TextStyle(color:isTeacher.value? Colors.white:Colors.black,
                                          fontWeight: FontWeight.w400,fontSize: 12.sp),)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(onTap: () {
                                    isTeacher.value=false;
                                    isCoordinate.value=true;
                                  // Get.toNamed(CoordinatorVerificationsScreen());
                                  },
                                    child: Container(
                                      margin:EdgeInsets.symmetric(horizontal: 0.5.w),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isCoordinate.value? MyColor.blueColor:Colors.white),
                                      child: Center(child:  Text("Coordinators",style: TextStyle(color: isCoordinate.value?Colors.white:Colors.black,
                                      fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                  getVertical(1.5.w),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of columns
                        crossAxisSpacing: 1.w,
                        mainAxisSpacing: 2.h,

                      ),
                      itemCount:isTeacher.value?data.length:data1.length,// Set the number of items to display
                      itemBuilder: (context, index) {
                        List<TeachersModel>userData=isTeacher.value?data:data1;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w), // Margin around each grid item
                          // margin: EdgeInsets.symmetric(vertical: 0.8.h), // Margin around each grid item
                          decoration: BoxDecoration(
                            color: MyColor.backgroundColor, // Background color of the container
                            borderRadius: BorderRadius.circular(14), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Shadow color
                                spreadRadius: 1, // Spread radius of the shadow
                                blurRadius: 4, // Blur radius of the shadow
                                offset: Offset(1, 1), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // getVertical(3.h),
                              CircleAvatar(
                                backgroundImage: AssetImage(userData[index].imageUrl), // Image for the avatar
                                radius: 4.w, // Radius of the avatar
                              ),
                              getVertical(1.2.h),
                              Flexible(
                                child: Text(
                                  userData[index].userName, // Title text
                                  style: Constant.textName,
                                  textAlign: TextAlign.center, // Center align the text
                                  overflow: TextOverflow.ellipsis, // Handle text overflow
                                ),
                              ),
                              getVertical(0.1.h),// Space between the title and email text
                              Flexible(
                                child: Text(
                                  userData[index].imageUrl, // Email text
                                  style: Constant.textEmail,
                                  textAlign: TextAlign.center, // Center align the text
                                  overflow: TextOverflow.ellipsis, // Handle text overflow
                                ),
                              ),
                              getVertical(1.h),
                              Flexible(
                                child: CustomApproveButton(buttonColor: MyColor.blueColor,
                                  buttonText: 'Approve',
                                  onPressed: () {  },),
                              ),
                              getVertical(1.h),
                              Flexible(
                                child: CustomTaskButton(buttonColor: MyColor.redColor,
                                  buttonText: 'Reject',
                                  onPressed: () {  },),
                              )

                            ],
                          ),
                        );
                      },
                    ),
                  ),

                ],) ,
              )
          ),
          getVertical(2.w),getHorizontal(2.w)
        ],
        ),
      ),
    ));
  }
}
