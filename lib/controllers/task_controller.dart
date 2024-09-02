import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctt/controllers/utils/toast_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/task_teacher_selection_model.dart';
import '../model/teachers_get_model.dart';
import 'file_picker_controller.dart';
import 'get_teacher_controller.dart';
import 'dart:html' as html;

class TaskController extends GetxController {
  RxBool isLoading = false.obs;
  var taskButtonStates = <String, String>{}.obs; // Add this line

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FilePickerController filePickerController = Get.put(FilePickerController());
  final GetTeacherController teacherController = Get.put(GetTeacherController());
  List<String> teacherIds = [];
  List<TeachersGetModel> teacherList = <TeachersGetModel>[].obs;
  var taskFilesData = <Map<String, dynamic>>[].obs; // To store the combined file and user data

  // Map to hold task statuses
  Map<String, String> taskStatuses = {};


  Future<List<TeachersGetModel>> fetchTeachersByIds(List<String> teacherIds) async {
    try {
      isLoading.value = true;
      List<TeachersGetModel> fetchedTeachers = [];

      for (String teacherId in teacherIds) {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(teacherId).get();
        if (doc.exists) {
          fetchedTeachers.add(TeachersGetModel.fromFirestore(doc));
        }
      }

      teacherList.assignAll(fetchedTeachers);
      isLoading.value = false;

      return fetchedTeachers;
    } catch (e) {
      isLoading.value = false;
      log("Error fetching teachers: $e");
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> addTask(BuildContext context, DateTime selectedDate) async {
    var userTitleName = titleController.text.trim();
    var userDescriptionName = descriptionController.text.trim();
    if (userTitleName.isEmpty) {
      CustomToast.showToast(context, "Title Name is not empty");
      return;
    } else if (userDescriptionName.isEmpty) {
      CustomToast.showToast(context, "Description is not empty");
      return;
    } else if (filePickerController.fileDocIds.isEmpty) {
      CustomToast.showToast(context, "Please upload at least one file");
      return;
    }
    if (teacherIds.isEmpty) {
      CustomToast.showToast(context, "Please select at least one teacher");
      return;
    }

    try {
      isLoading.value = true;
      DocumentReference taskRef = FirebaseFirestore.instance.collection("task").doc();
      await taskRef.set({
        "teachers": teacherIds,
        "userTitleName": userTitleName,
        "userDescriptionName": userDescriptionName,
        "fileUrls": filePickerController.fileDocIds,
        "status": "Need to work",
        "deadline": selectedDate,
      });

      // Add the task ID to the map with initial status
      taskStatuses[taskRef.id] = "need to work";

      log("Task added to Firestore successfully");
      isLoading.value = false;

      // Navigate to verification screen or any other screen
      // Get.off(() => const LoginScreen());
    } catch (e) {
      isLoading.value = false;
      log("Error creating task: $e");
      CustomToast.showToast(context, e.toString());
    }
  }

  Future<void> submit(BuildContext context, DateTime selectedDate) async {
    bool fileUploaded = await filePickerController.uploadFile();
    if (fileUploaded) {
      await addTask(context, selectedDate);
    } else {
      CustomToast.showToast(context, "Error uploading file");
    }
  }

  // Toggle teacher selection
  void toggleSelection(TaskTeacherSelectionModel teacher) {
    !teacherIds.contains(teacher.id) ? teacherIds.add(teacher.id) : teacherIds.remove(teacher.id);
    teacher.selected.value = !teacher.selected.value;
  }


//
  Future<void> fetchTaskFiles(String taskId) async {
    try {
      isLoading.value = true;

      // Fetch the task document
      DocumentSnapshot taskDoc = await FirebaseFirestore.instance.collection('task').doc(taskId).get();
           print("taskDoc: $taskId");
      if (taskDoc.exists) {
        List<String> fileDocIds = List<String>.from(taskDoc['fileUrls']);
        print("fileDocIds: $fileDocIds");
        // Clear previous task files data
        taskFilesData.clear();

        for (String fileId in fileDocIds) {
          // Fetch the file document from the 'files' collection
          DocumentSnapshot fileDoc = await FirebaseFirestore.instance.collection('files').doc(fileId).get();

          if (fileDoc.exists) {
            String fileName = fileDoc['fileName'];
            String fileUrl = fileDoc['fileUrl'];
            String userId = fileDoc['userId'];

            // Fetch user details using the userId
            DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

            if (userDoc.exists) {
              String userName = userDoc['userName'];
              String userEmail = userDoc['userEmail'];
              String profileImageUrl = userDoc['profileImageUrl'];
print("taskFilesData :$taskFilesData");
              // Combine file and user data into a map and add to taskFilesData
              taskFilesData.add({
                'fileName': fileName,
                'fileUrl': fileUrl,
                'userName': userName,
                'userEmail': userEmail,
                'profileImageUrl': profileImageUrl,
              });
            }
          }
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("Error fetching task files: $e");
    }
  }


  void downloadFile(String url, String fileName) {
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }
}
