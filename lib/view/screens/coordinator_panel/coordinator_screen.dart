import 'package:ctt/view/screens/athentications/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../../model/teachers_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';
class CoordinatorScreen extends StatefulWidget {
  const CoordinatorScreen({Key? key}) : super(key: key);

  @override
  State<CoordinatorScreen> createState() => _CoordinatorScreenState();
}

class _CoordinatorScreenState extends State<CoordinatorScreen> {
  List<TeachersModel> data=[
    TeachersModel(profileImageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/profile1.png", userName: "usman", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/notificationProfile.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/profile1.png", userName: "Joe Simt", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/profile2.png", userName: "zeeshan", userEmail: "abc@xyz.com"),
    TeachersModel(profileImageUrl: "assets/png/profile1.png", userName: "usman", userEmail: "abc@xyz.com"),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(children: [
          CustomCoordinateName(coordinateName: 'Coordinate Name', onLogout: () {
            Get.to(()=>const LoginScreen());
          },),
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
                  TextFormField(decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Transform.scale(scale: 0.5,
                          child: SvgPicture.asset("assets/svg/search.svg")),
                      hintText: "Search Coordinator",
                      isDense: true,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color: MyColor.blueColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color:MyColor.blueColor ))),),
                  getVertical(1.5.w),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of columns
                        crossAxisSpacing: 1.w,
                        mainAxisSpacing: 2.h,

                      ),
                      itemCount:data.length,// Set the number of items to display
                      itemBuilder: (context, index) {
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
                                backgroundImage: AssetImage(data[index].profileImageUrl), // Image for the avatar
                                radius: 4.w, // Radius of the avatar
                              ),
                              getVertical(1.2.h),
                              Flexible(
                                child: Text(
                                  data[index].userName, // Title text
                                  style: Constant.textName,
                                  textAlign: TextAlign.center, // Center align the text
                                  overflow: TextOverflow.ellipsis, // Handle text overflow
                                ),
                              ),
                              getVertical(0.1.h),// Space between the title and email text
                              Flexible(
                                child: Text(
                                  data[index].profileImageUrl, // Email text
                                  style: Constant.textEmail,
                                  textAlign: TextAlign.center, // Center align the text
                                  overflow: TextOverflow.ellipsis, // Handle text overflow
                                ),
                              ),
                              getVertical(1.h),
                              Flexible(
                                child: CustomApproveButton(buttonColor: MyColor.redColor,
                                  buttonText: 'Delete Account',
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
    );
  }
}
