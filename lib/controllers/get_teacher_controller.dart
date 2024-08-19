import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/task_teacher_selection_model.dart';

class GetTeacherController extends GetxController {
  Stream<List<TaskTeacherSelectionModel>> getTeachers() {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userType", isEqualTo: "teacher")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskTeacherSelectionModel> teachers = [];
      for (var doc in query.docs) {
        try {
          var data = doc.data() as Map<String, Object?>;
          var teacher = TaskTeacherSelectionModel.fromJson(doc.id, data);
          teachers.add(teacher);
        } catch (e) {
          log("Error parsing document ${doc.id}: $e");
        }
      }
      return teachers;
    });
  }
}
