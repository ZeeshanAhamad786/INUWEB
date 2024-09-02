import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
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
        profileImageUrl: 'assets/png/notificationProfile.png',
        userName: 'Shan',
        userEmail: 'abc@gmail.com',
        selected: false.obs,
        id: '1'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png',
        userName: 'umer',
        userEmail: 'abc@gmail.com',
        selected: false.obs,
        id: '2'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png',
        userName: 'rana',
        userEmail: 'abc@gmail.com',
        selected: false.obs,
        id: '3'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png',
        userName: 'ahmad',
        userEmail: 'abc@gmail.com',
        selected: false.obs,
        id: '4'),
    TaskTeacherSelectionModel(
        profileImageUrl: 'assets/png/notificationProfile.png',
        userName: 'Shan',
        userEmail: 'abc@gmail.com',
        selected: false.obs,
        id: '5')
  ];
  RxBool addNew = false.obs;
  RxBool editTask = false.obs;
  RxBool showDetail =false.obs;
  RxString selectedTaskTeacher = "".obs;
  @override
  void initState() {
    taskNewController.fetchTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Scaffold(
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
                                                        trailing: Obx(() =>
                                                            Container(
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
                                    Obx(() =>
                                    filePickerController.loading.value
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
                    ?
                Expanded(
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
                              child: Obx(() {
                                if (showDetail.value) {
                                  return FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(selectedTaskTeacher.value)
                                        .get(),
                                    builder: (context, teacherSnapshot) {
                                      if (teacherSnapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (teacherSnapshot.hasError) {
                                        return Center(child: Text('Error: ${teacherSnapshot.error}'));
                                      } else if (!teacherSnapshot.hasData || !teacherSnapshot.data!.exists) {
                                        return const Center(child: Text('Teacher not found.'));
                                      } else {
                                        final teacher = TeachersGetModel.fromFirestore(teacherSnapshot.data!);

                                        return Container(
                                          padding: EdgeInsets.only(top: 3.w, left: 3.w, right: 3.w, bottom: 8.2.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.black.withOpacity(0.25)),
                                          ),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: teacher.profileImageUrl.isNotEmpty
                                                    ? NetworkImage(teacher.profileImageUrl)
                                                    : const AssetImage("assets/png/notificationProfile.png") as ImageProvider,
                                                radius: 100,
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(teacher.userName, style: Constant.textNameBold),
                                              Text(teacher.userEmail, style: Constant.textEmail),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return const Center(child: Text('Select a teacher to view details.'));
                                }
                              }),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('task')
                                          .where('teachers', arrayContains: selectedTaskTeacher.value) // Filter tasks by selected teacher ID
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text("Error: ${snapshot.error}"));
                                        }
                                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                          return Center(child: Text("No tasks available for this teacher"));
                                        }

                                        List<TaskModel> tasks = snapshot.data!.docs
                                            .map((doc) => TaskModel.fromFirestore(doc))
                                            .toList();

                                        return Column(
                                          children: tasks.map((task) {
                                            return Container(
                                              // height: MediaQuery.of(context).size.height*.3,
                                              padding: EdgeInsets.only(left: 1.w, bottom: 1.5.w, right: 1.w, top: 1.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.black.withOpacity(0.25)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Task Title/Name", style: Constant.textEmail),
                                                  SizedBox(height: 1.h),
                                                  Text(task.userTitleName, style: Constant.textTitle),
                                                  SizedBox(height: 1.h),
                                                  Text("Task Description", style: Constant.textEmail),
                                                  SizedBox(height: 1.h),
                                                  Text(
                                                    task.userDescriptionName,
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
                                                            ? task.deadline.toString()
                                                            : "No Deadline",
                                                        style: Constant.textMainTitle,
                                                      ),
                                                      Text(
                                                        task.status,
                                                        style: Constant.textMainTitle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
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
                                            height: 15.w,
                                            child:
                                            ListView.builder(
                                              itemCount: taskController.taskFilesData.length,
                                              itemBuilder: (context, index) {
                                                var fileData = taskController.taskFilesData[index];
                                                return Container(
                                                  margin: EdgeInsets.symmetric(vertical: .5.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: MyColor.SearchColor,
                                                  ),

                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage: fileData['profileImageUrl'] != null && fileData['profileImageUrl'].isNotEmpty
                                                          ? NetworkImage(fileData['profileImageUrl'])
                                                          : AssetImage("assets/png/notificationProfile.png") as ImageProvider,
                                                      radius: 24,
                                                    ),
                                                    // Image.network(fileData['profileImageUrl']), // User profile image
                                                    title: Text(fileData['userName'], style: Constant.textMainTitle), // User name
                                                    subtitle: Text(fileData['userEmail'], style: Constant.textEmail), // User email
                                                    trailing: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          fileData['fileName'], // File name
                                                          style: Constant.textDocs,
                                                        ),
                                                        getHorizontal(.5.w),
                                                        IconButton(
                                                          icon: Icon(Icons.download),
                                                          onPressed: () {
                                                            if (GetPlatform.isWeb) {
                                                           taskController. downloadFile(fileData['fileUrl'], fileData['fileName']);
                                                            } else {
                                                              // Call your existing download method for mobile platforms
                                                              taskController.downloadFile(fileData['fileUrl'], fileData['fileName']);
                                                            }
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          ),
                                        ],
                                      ),
                                    ),



                                    // Container(
                                    //   padding: EdgeInsets.only(
                                    //       top: 0.5.w, right: 1.w, left: 1.w, bottom: 0.5.w),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(14),
                                    //     border: Border.all(color: MyColor.blueColor),
                                    //   ),
                                    //   child: Column(
                                    //     children: [
                                    //       CustomSearchTextField(
                                    //         hintText: "Search Task",
                                    //         hintStyle: Constant.textEmail,
                                    //         onChanged: (value) {
                                    //           log("Search value: $value");
                                    //           // Implement search functionality if needed
                                    //         },
                                    //       ),
                                    //       SizedBox(
                                    //         height: 15.w,
                                    //         child: StreamBuilder<QuerySnapshot>(
                                    //           stream: FirebaseFirestore.instance.collection('task').snapshots(),
                                    //           builder: (context, taskSnapshot) {
                                    //             if (taskSnapshot.connectionState == ConnectionState.waiting) {
                                    //               return Center(child: CircularProgressIndicator());
                                    //             } else if (taskSnapshot.hasError) {
                                    //               return Center(child: Text('Error: ${taskSnapshot.error}'));
                                    //             } else if (!taskSnapshot.hasData || taskSnapshot.data!.docs.isEmpty) {
                                    //               return Center(child: Text('No tasks found'));
                                    //             } else {
                                    //               var tasks = taskSnapshot.data!.docs;
                                    //
                                    //               return ListView.builder(
                                    //                 itemCount: tasks.length,
                                    //                 itemBuilder: (context, index) {
                                    //                   var taskData = tasks[index].data() as Map<String, dynamic>?;
                                    //
                                    //                   if (taskData == null) {
                                    //                     return ListTile(
                                    //                       title: Text('Task data is unavailable'),
                                    //                     );
                                    //                   }
                                    //
                                    //                   // Get file URLs from task document
                                    //                   List<String> fileUrls = List<String>.from(taskData['fileUrls'] ?? []);
                                    //
                                    //                   return FutureBuilder<List<Map<String, dynamic>>>(
                                    //                     future: taskController.fetchFilesAndUsers(fileUrls),
                                    //                     builder: (context, combinedSnapshot) {
                                    //                       if (combinedSnapshot.connectionState == ConnectionState.waiting) {
                                    //                         return Center(child: CircularProgressIndicator());
                                    //                       } else if (combinedSnapshot.hasError) {
                                    //                         return ListTile(
                                    //                           title: Text('Error fetching data'),
                                    //                         );
                                    //                       } else if (!combinedSnapshot.hasData || combinedSnapshot.data!.isEmpty) {
                                    //                         return ListTile(
                                    //                           title: Text('No files associated with this task'),
                                    //                         );
                                    //                       } else {
                                    //                         List<Map<String, dynamic>> combinedData = combinedSnapshot.data!;
                                    //
                                    //                         return Column(
                                    //                           children: combinedData.map((data) {
                                    //                             String profileImageUrl = data['profileImageUrl'] ?? '';
                                    //                             String userName = data['userName'] ?? 'Unnamed User';
                                    //                             String userEmail = data['userEmail'] ?? 'No Email';
                                    //                             String fileName = data['fileName'] ?? 'No File Name';
                                    //
                                    //                             return Container(
                                    //                               margin: EdgeInsets.symmetric(vertical: 0.5.w),
                                    //                               decoration: BoxDecoration(
                                    //                                 borderRadius: BorderRadius.circular(14),
                                    //                                 color: MyColor.SearchColor,
                                    //                               ),
                                    //                               child: ListTile(
                                    //                                 leading: CircleAvatar(
                                    //                                   backgroundImage: profileImageUrl.isNotEmpty
                                    //                                       ? NetworkImage(profileImageUrl)
                                    //                                       : const AssetImage("assets/png/notificationProfile.png") as ImageProvider,
                                    //                                   radius: 24,
                                    //                                 ),
                                    //                                 title: Text(userName, style: Constant.textMainTitle),
                                    //                                 subtitle: Text(userEmail, style: Constant.textEmail),
                                    //                                 trailing: Row(
                                    //                                   mainAxisSize: MainAxisSize.min,
                                    //                                   children: [
                                    //                                     Text(
                                    //                                       fileName,
                                    //                                       style: Constant.textDocs,
                                    //                                     ),
                                    //                                     SizedBox(width: 4),
                                    //                                     SvgPicture.asset("assets/svg/docs.svg"),
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                             );
                                    //                           }).toList(),
                                    //                         );
                                    //                       }
                                    //                     },
                                    //                   );
                                    //                 },
                                    //               );
                                    //             }
                                    //           },
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 0, // Spread radius
                            blurRadius: 8, // Blur radius
                            offset: const Offset(1, 1), // Shadow position (x, y)
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Teacher",
                                style: Constant.textName1,
                              ),
                              Text(
                                "Title",
                                style: Constant.textName1,
                              ),
                              Text(
                                "Deadline",
                                style: Constant.textName1,
                              ),
                              Text(
                                "Status",
                                style: Constant.textName1,
                              ),
                              getHorizontal(17.w)
                            ],
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('task').snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return ListView.builder(
                                    itemCount: 6, // Display 6 shimmer items while loading
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 40.0,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      width: 150.0,
                                                      height: 40.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Center(child: Text('No Tasks found.'));
                                } else {
                                  final taskDocs = snapshot.data!.docs;
                                  List<String> taskDocumentIds = taskDocs.map((doc) => doc.id).toList();

                                  return ListView.builder(
                                    itemCount: taskDocs.length,
                                    itemBuilder: (context, index) {
                                      final taskData = taskDocs[index].data() as Map<String, dynamic>;
                                      final List<String> teacherIds = List<String>.from(taskData['teachers'] ?? []);
                                      // Check if there are any teachers assigned to this task
                                      if (teacherIds.isEmpty) {
                                        return SizedBox.shrink(); // Don't display anything if no teachers are assigned
                                      }
                                      return FutureBuilder<List<TeachersGetModel>>(
                                        future: taskController.fetchTeachersByIds(teacherIds),
                                        builder: (context, teacherSnapshot) {
                                          if (teacherSnapshot.connectionState == ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey.shade100,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 10.0,
                                                            color: Colors.white,
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Container(
                                                            width: 150.0,
                                                            height: 10.0,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else if (teacherSnapshot.hasError) {
                                            return Center(child: Text('Error: ${teacherSnapshot.error}'));
                                          } else if (!teacherSnapshot.hasData || teacherSnapshot.data!.isEmpty) {
                                            return SizedBox.shrink(); // Don't display anything if no teachers are found
                                          } else {
                                            final teachers = teacherSnapshot.data!;

                                            return Column(
                                              children: teachers.map((teacher) {
                                                return _buildTeacherCard(teacher, taskData, taskDocumentIds[index]);
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
                          )
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

  Widget _buildTeacherCard(TeachersGetModel teacher, Map<String, dynamic>? taskData, String taskId) {
    final userTitleName = taskData?['userTitleName'] ?? "No Task Found";
    final deadline = teacher.deadline != null
        ? DateFormat('yyyy-MM-dd').format(teacher.deadline!)
        : "No Deadline";
    final status = taskData?['status'] ?? "Need to Work";

    // Determine if buttons should be enabled or disabled
    bool areButtonsEnabled = status != "Need to work";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(teacher.profileImageUrl),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teacher.userName, overflow: TextOverflow.ellipsis,style:Constant.textMainTitle ,),
                Text(teacher.userEmail, overflow: TextOverflow.ellipsis,style:Constant.textSelect ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(userTitleName, overflow: TextOverflow.ellipsis,style:Constant.textName2),
          ),
          Expanded(
            flex: 2,
            child: Text(deadline, overflow: TextOverflow.ellipsis,style:Constant.textName2),
          ),
          Expanded(
            flex: 2,
            child: Text(status, overflow: TextOverflow.ellipsis,style:Constant.textName2),
          ),
          const SizedBox(width: 10),
          CustomTaskButton(
            buttonColor: areButtonsEnabled ? Colors.blue : Colors.grey,
            buttonText: 'Approve',
            onPressed: areButtonsEnabled ? () {
              // Add your approve logic here
            } : null,
          ),
          const SizedBox(width: 10),
          CustomSatisfactoryButton(
            buttonColor: areButtonsEnabled ? Colors.blue : Colors.grey,
            buttonText: 'Satisfactory',
            onPressed: areButtonsEnabled ? () {
              // Add your satisfactory logic here
            } : null,
          ),
          const SizedBox(width: 10),
          CustomTaskButton(
            buttonColor: areButtonsEnabled ? Colors.red : Colors.grey,
            buttonText: 'Reject',
            onPressed: areButtonsEnabled ? () {
              // Add your reject logic here
            } : null,
          ),
          const SizedBox(width: 10),
          CustomTaskButton(
            buttonColor: Colors.grey,
            buttonText: 'Details',
            onPressed: () {
              selectedTaskTeacher.value = teacher.id; // Set the document ID
              showDetail.value = true;
              taskController.fetchTaskFiles(taskId);

            }// Set the visibility flag            },
          ),
        ],
      ),
    );
  }}


