import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctt/controllers/utils/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/task_teacher_selection_model.dart';
import '../model/teachers_get_model.dart';
import 'file_picker_controller.dart';
import 'get_teacher_controller.dart';

class TaskController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FilePickerController filePickerController = Get.put(FilePickerController());
  final GetTeacherController teacherController = Get.put(GetTeacherController());
  List<String> teacherIds = [];
  List<TeachersGetModel> teacherList=<TeachersGetModel>[].obs;

  // Map to hold task statuses
  Map<String, String> taskStatuses = {};

  // Fetch teachers by IDs
  Future<void> fetchTeachersByIds(List<String> teacherIds) async {
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
    } catch (e) {
      isLoading.value = false;
      log("Error fetching teachers: $e");
    }
  }

  // Add task
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
        "status": "need to work",
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
// Update task status for a specific taskId and teacherId
  Future<void> updateTasksForTeacher(String teacherId, String status) async {
    try {
      // Log the parameters for debugging
      log("Updating tasks for Teacher ID: $teacherId with Status: $status");

      // Fetch tasks associated with the specific teacher
      QuerySnapshot tasksSnapshot = await FirebaseFirestore.instance
          .collection('task')
          .where('teachers', arrayContains: teacherId)
          .get();

      // Log the number of documents fetched
      log("Number of tasks found: ${tasksSnapshot.docs.length}");

      if (tasksSnapshot.docs.isEmpty) {
        log("No tasks found for teacher ID: $teacherId.");
        return;
      }

      // Update the status of each task
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (QueryDocumentSnapshot taskDoc in tasksSnapshot.docs) {
        DocumentReference taskRef = taskDoc.reference;

        batch.update(taskRef, {
          'status': status,
        });

        log("Prepared to update status for Task ID: ${taskDoc.id}");
      }

      // Commit the batch update
      await batch.commit();
      log("Successfully updated status to '$status' for ${tasksSnapshot.docs.length} tasks.");

    } catch (e) {
      log("Error updating task statuses: $e");
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
}
