import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/file_picker_controller.dart';
import '../../../controllers/get_teacher_controller.dart';
import '../../../controllers/image_picker_controller.dart';
import '../../../controllers/task_controller.dart';
import '../../../controllers/task_new_controller.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../../model/task_model.dart';
import '../../../model/task_teacher_selection_model.dart';
import '../../../model/teachers_get_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import '../../custom_widgets/custom_textfield.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  ImagePickerController imagePickerController = Get.put(ImagePickerController());
  GetTeacherController getTeacherController = Get.put(GetTeacherController());
  FilePickerController filePickerController = Get.put(FilePickerController());
  TaskController taskController = Get.put(TaskController());
  final TaskNewController taskNewController = Get.put(TaskNewController());

//// editTask.value? editTask.value = false:addNew.value=false; submit button back logic
  DateTime _selectedDate = DateTime.now();
  // List<TaskModel> data = [
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "Eshan",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Need to Work"),
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "Rana",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Done"),
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "Mohsin",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Need to Work"),
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "hello",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Need to Work"),
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "Eshan",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Need to Work"),
  //   TaskModel(
  //       profileImageUrl: "assets/png/profile1.png",
  //       userName: "Eshan",
  //       userEmail: "abc@xyz.com",
  //       userTitle: "New upcoming topic",
  //       userDeadline: "01 June 04:30 PM",
  //       userStatus: "Need to Work"),
  // ];
  List<TaskTeacherSelectionModel> data1 = [
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png', userName: 'Shan', userEmail: 'abc@gmail.com', selected: false.obs, id: '1'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png', userName: 'umer', userEmail: 'abc@gmail.com', selected: false.obs, id: '2'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png', userName: 'rana', userEmail: 'abc@gmail.com', selected: false.obs, id: '3'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png', userName: 'ahmad', userEmail: 'abc@gmail.com', selected: false.obs, id: '4'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png', userName: 'Shan', userEmail: 'abc@gmail.com', selected: false.obs, id: '5')
  ];
  RxBool addNew = false.obs;
  RxBool editTask = false.obs;
  RxBool showDetail = false.obs;
@override
  void initState() {
  taskNewController.fetchTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                CustomCoordinateName(
                  coordinateName: 'Coordinate Name',
                  onLogout: () {
                    Get.offAllNamed('/LoginScreen');
                  },
                ),
                editTask.value || addNew.value
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.25),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      editTask.value ? editTask.value = false : addNew.value = false;
                                    },
                                    child: Container(
                                      height: 2.5.w,
                                      width: 2.5.w,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyColor.backgroundColor),
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back,
                                        size: 16.px,
                                      )),
                                    ),
                                  ),
                                ),
                                getVertical(2.h),
                                Text(
                                  "Task Title/Name",
                                  style: Constant.textEmail,
                                ),
                                getVertical(0.5.h),
                                CustomTextFormField(
                                  controller: taskController.titleController,
                                  hintText: "Enter Task title",
                                  fillColor: MyColor.SearchColor,
                                  hintStyle: Constant.textGreySign,
                                  borderColor: MyColor.blueColor,
                                  contentPadding: EdgeInsets.all(1.w),
                                ),
                                getVertical(2.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Task Description (Optional)", style: Constant.textEmail),
                                          SizedBox(height: .5.h),
                                          CustomTextFormFieldLine(
                                            controller: taskController.descriptionController,
                                            maxLines: 9,
                                            hintText: "Enter task description",
                                            hintStyle: Constant.textGreySign,
                                            fillColor: MyColor.SearchColor,
                                            borderColor: MyColor.blueColor,
                                          ),
                                          SizedBox(height: 1.h),
                                          Text("File Upload (Optional)", style: Constant.textEmail),
                                          SizedBox(height: 1.h),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () async {
                                                await filePickerController.getFile();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w), // Adjust these values as needed
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(color: MyColor.blueColor),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Obx(() {
                                                      return Text(
                                                        filePickerController.fileName.isNotEmpty
                                                            ? filePickerController.fileName.value
                                                            : "Click to upload file (optional)",
                                                        style: Constant.textForgot,
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    getHorizontal(1.w),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("Teachers selection", style: Constant.textEmail),
                                          getVertical(.5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: MyColor.blueColor),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: CustomSearchTextField(
                                                        hintText: "Search Task",
                                                        hintStyle: Constant.textEmail,
                                                        onChanged: (value) {
                                                          log("Search value: $value");
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // Toggle all selected values
                                                          bool allSelected = data1.every((element) => element.selected.value);
                                                          for (var item in data1) {
                                                            item.selected.value = !allSelected;
                                                          }
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset("assets/svg/allselected.svg"),
                                                            Text(
                                                              "Select all",
                                                              style: Constant.textSelect,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                // my current work

                                                StreamBuilder<List<TaskTeacherSelectionModel>>(
                                                  stream: getTeacherController.getTeachers(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return const Center(child: CircularProgressIndicator());
                                                    } else if (snapshot.hasError) {
                                                      return Center(child: Text("Error: ${snapshot.error}"));
                                                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                                      return const Center(child: Text("No teachers found."));
                                                    }

                                                    List<TaskTeacherSelectionModel> data1 = snapshot.data!;
                                                    return SizedBox(
                                                      height: 20.w,
                                                      child: ListView.builder(
                                                        itemCount: data1.length,
                                                        itemBuilder: (context, index) {
                                                          final teacher = data1[index];
                                                          return Container(
                                                            margin: EdgeInsets.symmetric(vertical: 1.w),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(14),
                                                              color: MyColor.SearchColor,
                                                            ),
                                                            child: ListTile(
                                                              leading: teacher.profileImageUrl != null
                                                                  ? CircleAvatar(
                                                                      backgroundImage: NetworkImage(teacher.profileImageUrl!),
                                                                      onBackgroundImageError: (error, stackTrace) {
                                                                        log("Error loading image: ${error.toString()}");
                                                                        log("StackTrace: ${stackTrace.toString()}");
                                                                        log("Error URL: ${teacher.profileImageUrl}");
                                                                      },
                                                                      backgroundColor: Colors.grey.shade200,
                                                                    )
                                                                  : CircleAvatar(
                                                                      child: Icon(Icons.person),
                                                                      backgroundColor: Colors.grey.shade200,
                                                                    ),
                                                              title: Text(teacher.userName, style: Constant.textMainTitle),
                                                              subtitle: Text(teacher.userEmail, style: Constant.textEmail),
                                                              trailing: Obx(() => Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      border: Border.all(color: MyColor.blueColor),
                                                                      color: teacher.selected.value ? MyColor.blueColor : Colors.white,
                                                                    ),
                                                                    child: Center(
                                                                      child: Icon(
                                                                        Icons.check,
                                                                        size: 12,
                                                                        color: teacher.selected.value ? Colors.white : MyColor.blueColor,
                                                                      ),
                                                                    ),
                                                                  )),
                                                              onTap: () {
                                                                taskController.toggleSelection(teacher);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Task Deadline',
                                            style: Constant.textEmail,
                                          ),
                                          getVertical(.5.h),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: MyColor.blueColor),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: dp.DayPicker.single(
                                              selectedDate: _selectedDate,
                                              onChanged: (DateTime date) {
                                                setState(() {
                                                  _selectedDate = date;
                                                });
                                              },
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2040),
                                            ),
                                          ),
                                          SizedBox(height: .5.h),
                                          Obx(() => filePickerController.loading.value
                                              ? const Center(
                                                  child: CircularProgressIndicator(
                                                  color: MyColor.blueColor,
                                                ))
                                              : GestureDetector(
                                                  onTap: () async {
                                                    await taskController.submit(context, _selectedDate);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: .5.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: MyColor.blueColor,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Submit",
                                                      style: Constant.textSubmit,
                                                    )),
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : showDetail.value == true
                        ?Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        EditTaskComponent(
                          showDetail: showDetail,
                          addNewOrEdit: editTask,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('users').snapshots(), // Stream of users collection
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return const Center(child: Text('No user found.'));
                                  } else {
                                    final userDoc = snapshot.data!.docs.first; // Assuming you want the first user's data
                                    final String userName = userDoc['userName']; // Replace 'name' with the actual field name in Firestore
                                    final String userEmail = userDoc['userEmail']; // Replace 'email' with the actual field name in Firestore
                                    final String profileImageUrl = userDoc['profileImageUrl']; // Replace 'email' with the actual field name in Firestore

                                    return Container(
                                      padding: EdgeInsets.only(top: 3.w, left: 3.w, right: 3.w, bottom: 8.2.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.black.withOpacity(0.25)),
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: profileImageUrl.isNotEmpty
                                                ? NetworkImage(profileImageUrl)
                                                : const AssetImage("assets/png/notificationProfile.png") as ImageProvider,
                                            radius: 100, // Adjust radius as needed
                                          ),

                                          SizedBox(height: 2.h),
                                          Text(userName, style: Constant.textNameBold), // Display the fetched name
                                          Text(userEmail, style: Constant.textEmail), // Display the fetched email
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('task').snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator()); // Loading indicator while data is being fetched
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text("Error: ${snapshot.error}")); // Display error if something goes wrong
                                        }

                                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                          return Center(child: Text("No tasks available")); // Display message if no data is available
                                        }

                                        // Map Firestore documents to TaskModel objects
                                        List<TaskModel> tasks = snapshot.data!.docs
                                            .map((doc) => TaskModel.fromFirestore(doc))
                                            .toList();

                                        return Column(
                                          children: tasks.map((task) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 1.w, bottom: 1.5.w, right: 1.w, top: 1.w),
                                              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.black.withOpacity(0.25)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Task Title/Name", style: Constant.textEmail),
                                                  SizedBox(height: 1.h),
                                                  Text(task.userTitleName, style: Constant.textTitle), // Displaying task title
                                                  SizedBox(height: 1.h),
                                                  Text("Task Description", style: Constant.textEmail),
                                                  SizedBox(height: 1.h),
                                                  Text(
                                                    task.userDescriptionName, // Displaying task description
                                                    style: Constant.textTitle,
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Deadline", style: Constant.textEmail),
                                                      Text("Status", style: Constant.textEmail),
                                                    ],
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        task.deadline != null
                                                            ? task.deadline.toString() // Convert Timestamp to DateTime and then to String
                                                            : "No Deadline", // Fallback if the deadline is null
                                                        style: Constant.textMainTitle,
                                                      ),
                                                      Text(
                                                        task.status, // Displaying task status
                                                        style: Constant.textMainTitle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(), // Using toList() to convert the Iterable back to a List
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      padding: EdgeInsets.only(top: .5.w, right: 1.w, left: 1.w, bottom: .5.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: MyColor.blueColor),
                                      ),
                                      child: Column(
                                        children: [
                                          CustomSearchTextField(
                                            hintText: "Search Task",
                                            hintStyle: Constant.textEmail,
                                            onChanged: (value) {
                                              log("Search value: $value");
                                            },
                                          ),
                                          SizedBox(
                                            height: 9.w,
                                            child: ListView.builder(
                                              itemCount: data1.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(vertical: .5.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: MyColor.SearchColor,
                                                  ),
                                                  child: ListTile(
                                                      leading: Image.asset(data1[index].profileImageUrl),
                                                      title: Text(data1[index].userName, style: Constant.textMainTitle),
                                                      subtitle: Text(data1[index].userEmail, style: Constant.textEmail),
                                                      trailing: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "Task.docx",
                                                            style: Constant.textDocs,
                                                          ),
                                                          getHorizontal(.5.w),
                                                          SvgPicture.asset("assets/svg/docs.svg")
                                                        ],
                                                      )),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )

                // SingleChildScrollView(
                //             child: Column(
                //               children: [
                //                 EditTaskComponent(
                //                   showDetail: showDetail,
                //                   addNewOrEdit: editTask,
                //                 ),
                //                 SizedBox(height: 2.h),
                //                 Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Expanded(
                //                       child: StreamBuilder<QuerySnapshot>(
                //                         stream: FirebaseFirestore.instance.collection('users').snapshots(), // Stream of users collection
                //                         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //                           if (snapshot.connectionState == ConnectionState.waiting) {
                //                             return const Center(child: CircularProgressIndicator());
                //                           } else if (snapshot.hasError) {
                //                             return Center(child: Text('Error: ${snapshot.error}'));
                //                           } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                //                             return const Center(child: Text('No user found.'));
                //                           } else {
                //                             final userDoc = snapshot.data!.docs.first; // Assuming you want the first user's data
                //                             final String userName = userDoc['userName']; // Replace 'name' with the actual field name in Firestore
                //                             final String userEmail = userDoc['userEmail']; // Replace 'email' with the actual field name in Firestore
                //                             final String profileImageUrl = userDoc['profileImageUrl']; // Replace 'email' with the actual field name in Firestore
                //
                //                             return Container(
                //                               padding: EdgeInsets.only(top: 3.w, left: 3.w, right: 3.w, bottom: 8.2.w),
                //                               decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.circular(20),
                //                                 border: Border.all(color: Colors.black.withOpacity(0.25)),
                //                               ),
                //                               child: Column(
                //                                 children: [
                //                                   CircleAvatar(
                //                               backgroundImage: profileImageUrl.isNotEmpty
                //                               ? NetworkImage(profileImageUrl)
                //                                     : const AssetImage("assets/png/notificationProfile.png") as ImageProvider,
                //                           radius: 100, // Adjust radius as needed
                //                           ),
                //
                //                                   SizedBox(height: 2.h),
                //                                   Text(userName, style: Constant.textNameBold), // Display the fetched name
                //                                   Text(userEmail, style: Constant.textEmail), // Display the fetched email
                //                                 ],
                //                               ),
                //                             );
                //                           }
                //                         },
                //                       ),
                //                     ),
                //                     SizedBox(width: 2.w),
                //                     Expanded(
                //                       child: Column(
                //                         children: [
                //                           Container(
                //                             padding: EdgeInsets.only(left: 1.w, bottom: 1.5.w, right: 1.w, top: 1.w),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.circular(20),
                //                               border: Border.all(color: Colors.black.withOpacity(0.25)),
                //                             ),
                //                             child: Column(
                //                               crossAxisAlignment: CrossAxisAlignment.start,
                //                               children: [
                //                                 Text("Task Title/Name", style: Constant.textEmail),
                //                                 SizedBox(height: 1.h),
                //                                 Text("New upcoming topic", style: Constant.textTitle),
                //                                 SizedBox(height: 1.h),
                //                                 Text("Task Description", style: Constant.textEmail),
                //                                 SizedBox(height: 1.h),
                //                                 Text(
                //                                   """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu ipsum at leo euismod suscipit eu nec justo. Nulla ultrices in nunc nec vulputate. Praesent condimentum neque id semper efficitur. Suspendisse at nulla eu velit fringilla consequat. Aenean ornare sapien vitae...""",
                //                                   style: Constant.textTitle,
                //                                 ),
                //                                 SizedBox(height: 1.h),
                //                                 Row(
                //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                   children: [
                //                                     Text(
                //                                       "Deadline",
                //                                       style: Constant.textEmail,
                //                                     ),
                //                                     Text(
                //                                       "Status",
                //                                       style: Constant.textEmail,
                //                                     ),
                //                                   ],
                //                                 ),
                //                                 SizedBox(height: 1.h),
                //                                 Row(
                //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                   children: [
                //                                     Text(
                //                                       "01 June 04:30 PM",
                //                                       style: Constant.textMainTitle,
                //                                     ),
                //                                     Text(
                //                                       "Approved",
                //                                       style: Constant.textMainTitle,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                           SizedBox(height: 2.h),
                //                           Container(
                //                             padding: EdgeInsets.only(top: .5.w, right: 1.w, left: 1.w, bottom: .5.w),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.circular(14),
                //                               border: Border.all(color: MyColor.blueColor),
                //                             ),
                //                             child: Column(
                //                               children: [
                //                                 CustomSearchTextField(
                //                                   hintText: "Search Task",
                //                                   hintStyle: Constant.textEmail,
                //                                   onChanged: (value) {
                //                                     log("Search value: $value");
                //                                   },
                //                                 ),
                //                                 SizedBox(
                //                                   height: 9.w,
                //                                   child: ListView.builder(
                //                                     itemCount: data1.length,
                //                                     itemBuilder: (context, index) {
                //                                       return Container(
                //                                         margin: EdgeInsets.symmetric(vertical: .5.w),
                //                                         decoration: BoxDecoration(
                //                                           borderRadius: BorderRadius.circular(14),
                //                                           color: MyColor.SearchColor,
                //                                         ),
                //                                         child: ListTile(
                //                                             leading: Image.asset(data1[index].profileImageUrl),
                //                                             title: Text(data1[index].userName, style: Constant.textMainTitle),
                //                                             subtitle: Text(data1[index].userEmail, style: Constant.textEmail),
                //                                             trailing: Row(
                //                                               mainAxisSize: MainAxisSize.min,
                //                                               children: [
                //                                                 Text(
                //                                                   "Task.docx",
                //                                                   style: Constant.textDocs,
                //                                                 ),
                //                                                 getHorizontal(.5.w),
                //                                                 SvgPicture.asset("assets/svg/docs.svg")
                //                                               ],
                //                                             )),
                //                                       );
                //                                     },
                //                                   ),
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           )
                        : Expanded(
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
                                getVertical(2.h),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Transform.scale(scale: 0.5, child: SvgPicture.asset("assets/svg/search.svg")),
                                            hintText: "Search Task",
                                            hintStyle: Constant.textEmail,
                                            isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: MyColor.blueColor)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: MyColor.blueColor))),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 1.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            addNew.value = true;
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColor.blueColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 1.5.w),
                                          ),
                                          child: Text(
                                            "Add New Task",
                                            style: Constant.textAddNewTask,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                getVertical(1.5.w),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Teacher",
                                      style: Constant.textMainTitle,
                                    ),
                                    Text(
                                      "Topic",
                                      style: Constant.textMainTitle,
                                    ),
                                    Text(
                                      "Deadline",
                                      style: Constant.textMainTitle,
                                    ),
                                    Text(
                                      "Status",
                                      style: Constant.textMainTitle,
                                    ),
                                    getHorizontal(15.w)
                                  ],
                                ),
                                // Expanded(
                                //   child: StreamBuilder<QuerySnapshot>(
                                //     stream: FirebaseFirestore.instance.collection('users').snapshots(), // Stream of users collection
                                //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                //       if (snapshot.connectionState == ConnectionState.waiting) {
                                //         return const Center(child: CircularProgressIndicator());
                                //       } else if (snapshot.hasError) {
                                //         return Center(child: Text('Error: ${snapshot.error}'));
                                //       } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                //         return const Center(child: Text('No teachers found.'));
                                //       } else {
                                //         final teacherList = snapshot.data!.docs.map((doc) {
                                //           return TeachersGetModel.fromFirestore(doc); // Assuming you have a TeacherModel class
                                //         }).toList();
                                //
                                //         return ListView.builder(
                                //           itemCount: teacherList.length,
                                //           itemBuilder: (context, index) {
                                //             final teacher = teacherList[index];
                                //
                                //             return Container(
                                //               margin: EdgeInsets.symmetric(vertical: 1.h),
                                //               padding: EdgeInsets.only(left: 0.5.w, right: 1.w, top: 0.5.w, bottom: 0.5.w),
                                //               decoration: BoxDecoration(
                                //                 borderRadius: BorderRadius.circular(10),
                                //                 color: MyColor.backgroundColor,
                                //               ),
                                //               child: Row(
                                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                 crossAxisAlignment: CrossAxisAlignment.center,
                                //                 children: [
                                //                   CircleAvatar(
                                //                     backgroundImage: NetworkImage(teacher.profileImageUrl),
                                //                   ),
                                //                   Expanded(
                                //                     flex: 2,
                                //                     child: Column(
                                //                       crossAxisAlignment: CrossAxisAlignment.start,
                                //                       children: [
                                //                         Text(teacher.userName),
                                //                         Text(teacher.userEmail),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                   Expanded(flex: 2, child: Text(teacher.userTitleName)),
                                //                   Expanded(flex: 2, child: Text(teacher.deadline != null
                                //                       ? teacher.deadline.toString() // Convert Timestamp to DateTime and then to String
                                //                       : "No Deadline", )),
                                //                   Expanded(flex: 2, child: Text("Need to Work")),
                                //                   CustomTaskButton(
                                //                     buttonColor: MyColor.blueColor,
                                //                     buttonText: 'Approve',
                                //                     onPressed: () {},
                                //                   ),
                                //                   getHorizontal(.8.h),
                                //                   CustomSatisfactoryButton(
                                //                     buttonColor: MyColor.blueColor,
                                //                     buttonText: 'Satisfactory',
                                //                     onPressed: () {},
                                //                   ),
                                //                   getHorizontal(.8.h),
                                //                   CustomTaskButton(
                                //                     buttonColor: MyColor.redColor,
                                //                     buttonText: 'Reject',
                                //                     onPressed: () {},
                                //                   ),
                                //                   getHorizontal(.8.h),
                                //                   CustomTaskButton(
                                //                     buttonColor: MyColor.greyColor,
                                //                     buttonText: 'Details',
                                //                     onPressed: () {
                                //                       showDetail.value = true;
                                //                     },
                                //                   ),
                                //                 ],
                                //               ),
                                //             );
                                //           },
                                //         );
                                //       }
                                //     },
                                //   ),
                                // )
                                Expanded(
                                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> userSnapshot) {
                                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (userSnapshot.hasError) {
                                        return Center(child: Text('Error: ${userSnapshot.error}'));
                                      } else if (!userSnapshot.hasData || userSnapshot.data!.docs.isEmpty) {
                                        return const Center(child: Text('No teachers found.'));
                                      } else {
                                        final teacherList = userSnapshot.data!.docs.map((doc) {
                                          return TeachersGetModel.fromFirestore(doc);
                                        }).toList();

                                        return ListView.builder(
                                          itemCount: teacherList.length,
                                          itemBuilder: (context, index) {
                                            final teacher = teacherList[index];

                                            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('task')
                                                  .where('teachers', arrayContains: teacher.id)
                                                  .snapshots(),
                                              builder: (context, taskSnapshot) {
                                                if (taskSnapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                } else if (taskSnapshot.hasError) {
                                                  return Center(child: Text('Error: ${taskSnapshot.error}'));
                                                } else if (!taskSnapshot.hasData || taskSnapshot.data!.docs.isEmpty) {
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                                    padding: EdgeInsets.only(left: 0.5.w, right: 1.w, top: 0.5.w, bottom: 0.5.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: MyColor.backgroundColor,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: NetworkImage(teacher.profileImageUrl),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(teacher.userName),
                                                              Text(teacher.userEmail),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(flex: 2, child: Text("No Task Found")),
                                                        Expanded(flex: 2, child: Text("No Deadline")),
                                                        Expanded(flex: 2, child: Text("Need to Work")),
                                                        CustomTaskButton(
                                                          buttonColor: MyColor.blueColor,
                                                          buttonText: 'Approve',
                                                          onPressed: () {},
                                                        ),
                                                        SizedBox(width: 0.8.h),
                                                        CustomSatisfactoryButton(
                                                          buttonColor: MyColor.blueColor,
                                                          buttonText: 'Satisfactory',
                                                          onPressed: () {},
                                                        ),
                                                        SizedBox(width: 0.8.h),
                                                        CustomTaskButton(
                                                          buttonColor: MyColor.redColor,
                                                          buttonText: 'Reject',
                                                          onPressed: () {},
                                                        ),
                                                        SizedBox(width: 0.8.h),
                                                        CustomTaskButton(
                                                          buttonColor: MyColor.greyColor,
                                                          buttonText: 'Details',
                                                          onPressed: () {
                                                            showDetail.value = true;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  final taskDocs = taskSnapshot.data!.docs;

                                                  return Column(
                                                    children: taskDocs.map((taskDoc) {
                                                      final taskData = taskDoc.data(); // Use the data() method on DocumentSnapshot
                                                      final taskId = taskDoc.id; // Extract the taskId here
                                                      final userTitleName = taskData['userTitleName'] ?? "No Title";
                                                      final deadline = taskData['deadline'] != null
                                                          ? (taskData['deadline'] as Timestamp).toDate().toString()
                                                          : "No Deadline";
                                                      final status = taskData['status'] ?? "Need to Work";

                                                      return Container(
                                                        margin: EdgeInsets.symmetric(vertical: 1.h),
                                                        padding: EdgeInsets.only(left: 0.5.w, right: 1.w, top: 0.5.w, bottom: 0.5.w),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: MyColor.backgroundColor,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(teacher.profileImageUrl),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(teacher.userName),
                                                                  Text(teacher.userEmail),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(flex: 2, child: Text(userTitleName)),
                                                            Expanded(flex: 2, child: Text(deadline)),
                                                            Expanded(flex: 2, child: Text(status)),
                                                            CustomTaskButton(
                                                              buttonColor: MyColor.blueColor,
                                                              buttonText: 'Approve',
                                                              onPressed: () {
                                                                Get.find<TaskController>().updateTasksForTeacher(teacher.id,"Approved");
                                                              },
                                                            ),
                                                            SizedBox(width: 0.8.h),
                                                            CustomSatisfactoryButton(
                                                              buttonColor: MyColor.blueColor,
                                                              buttonText: 'Satisfactory',
                                                              onPressed: () {
                                                                Get.find<TaskController>().updateTasksForTeacher(teacher.id,"Satisfactory");
                                                              },
                                                            ),
                                                            SizedBox(width: 0.8.h),
                                                            CustomTaskButton(
                                                              buttonColor: MyColor.redColor,
                                                              buttonText: 'Reject',
                                                              onPressed: () {
                                                                Get.find<TaskController>().updateTasksForTeacher(teacher.id,"Rejected");
                                                              },
                                                            ),
                                                            SizedBox(width: 0.8.h),
                                                            CustomTaskButton(
                                                              buttonColor: MyColor.greyColor,
                                                              buttonText: 'Details',
                                                              onPressed: () {
                                                                showDetail.value = true;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),


                              ],
                            ),
                          )),
                getVertical(2.w),
                getHorizontal(2.w)
              ],
            ),
          ),
        ));
  }
}

