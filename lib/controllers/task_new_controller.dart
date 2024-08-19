import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/task_model.dart';

class TaskNewController extends GetxController {
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxBool isLoading = false.obs;

  // Fetch tasks from Firestore
  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('task').get();

      List<TaskModel> fetchedTasks = querySnapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();

      tasks.assignAll(fetchedTasks);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("Error fetching tasks: $e");
    }
  }
}
