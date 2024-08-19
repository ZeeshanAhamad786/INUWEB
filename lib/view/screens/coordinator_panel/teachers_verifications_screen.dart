import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../../model/teachers_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';

class TeachersVerificationsScreen extends StatefulWidget {
  const TeachersVerificationsScreen({super.key});

  @override
  State<TeachersVerificationsScreen> createState() =>
      _TeachersVerificationsScreenState();
}

class _TeachersVerificationsScreenState
    extends State<TeachersVerificationsScreen> {
  RxBool isTeacher = true.obs;
  RxBool isCoordinate = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            CustomCoordinateName(
              coordinateName: 'Coordinate Name',
              onLogout: () {
                Get.offAllNamed('/LoginScreen');
              },
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
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
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Transform.scale(
                                  scale: 0.5,
                                  child: SvgPicture.asset(
                                      "assets/svg/search.svg"),
                                ),
                                hintText: isTeacher.value
                                    ? "Search Teacher"
                                    : "Search Coordinator",
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                  BorderSide(color: MyColor.blueColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                  BorderSide(color: MyColor.blueColor),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(left: 1.w),
                              padding:
                              EdgeInsets.symmetric(vertical: 0.46.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: MyColor.blueColor)),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        isTeacher.value = true;
                                        isCoordinate.value = false;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0.5.w),
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: isTeacher.value
                                              ? MyColor.blueColor
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Teachers",
                                            style: TextStyle(
                                              color: isTeacher.value
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        isTeacher.value = false;
                                        isCoordinate.value = true;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0.5.w),
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: isCoordinate.value
                                              ? MyColor.blueColor
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Coordinators",
                                            style: TextStyle(
                                              color: isCoordinate.value
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.5.w),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where(
                              'userType',
                              isEqualTo: isTeacher.value
                                  ? 'teacher'
                                  : 'coordinator')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No users found'));
                            }

                            var data = snapshot.data!.docs;

                            return GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Number of columns
                                crossAxisSpacing:
                                1.w, // Space between columns
                                mainAxisSpacing: 2.h, // Space between rows
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var userData = data[index];
                                var userName = userData['userName'];
                                var userEmail = userData['userEmail'];
                                var profileImageUrl =
                                userData['profileImageUrl'];

                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    color: MyColor.backgroundColor,
                                    borderRadius: BorderRadius.circular(14),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                        NetworkImage(profileImageUrl),
                                        radius: 4.w, // Radius of the avatar
                                      ),
                                      SizedBox(height: 1.2.h),
                                      Flexible(
                                        child: Text(
                                          userName, // Title text
                                          style: Constant.textName,
                                          textAlign: TextAlign.center, // Center align the text
                                          overflow: TextOverflow.ellipsis, // Handle text overflow
                                        ),
                                      ),
                                      SizedBox(height: 0.1.h),
                                      Flexible(
                                        child: Text(
                                          userEmail, // Email text
                                          style: Constant.textEmail,
                                          textAlign: TextAlign.center, // Center align the text
                                          overflow: TextOverflow.ellipsis, // Handle text overflow
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Flexible(
                                        child: CustomApproveButton(
                                          buttonColor: MyColor.blueColor,
                                          buttonText: 'Approve',
                                          onPressed: () {
                                            // Add approve functionality here
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Flexible(
                                        child: CustomApproveButton(
                                          buttonColor: MyColor.redColor,
                                          buttonText: 'Reject',
                                          onPressed: () {
                                            // Add reject functionality here
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 2.w),
            SizedBox(height: 2.w),
          ],
        ),
      ),
    ));
  }
}
