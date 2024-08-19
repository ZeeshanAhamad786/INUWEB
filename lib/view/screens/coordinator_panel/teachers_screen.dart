import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({Key? key}) : super(key: key);

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset("assets/svg/search.svg"),
                        ),
                        hintText: "Search Teacher",
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: MyColor.blueColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: MyColor.blueColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.5.w),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('userType', isEqualTo: 'teacher').
                          where('verified', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text('No teachers found'));
                          }

                          var data = snapshot.data!.docs;

                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // Number of columns
                              crossAxisSpacing: 1.w, // Space between columns
                              mainAxisSpacing: 2.h, // Space between rows
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var userData = data[index];
                              var userName = userData['userName'];
                              var userEmail = userData['userEmail'];
                              var profileImageUrl = userData['profileImageUrl'];

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(profileImageUrl),
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
                                        buttonColor: MyColor.redColor,
                                        buttonText: 'Delete Account',
                                        onPressed: () {
                                          // Add delete account functionality here
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
              ),
            ),
            SizedBox(height: 2.w),
            SizedBox(height: 2.w),
          ],
        ),
      ),
    );
  }
}
