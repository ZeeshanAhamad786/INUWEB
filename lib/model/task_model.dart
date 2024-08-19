import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String userTitleName;
  String userDescriptionName;
  DateTime? deadline; // Nullable DateTime
  String status;

  TaskModel({
    required this.userTitleName,
    required this.userDescriptionName,
    this.deadline, // Make deadline nullable
    required this.status,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return TaskModel(
      userTitleName: data['userTitleName'] ?? '',
      userDescriptionName: data['userDescriptionName'] ?? '',
      deadline: data['deadline'] != null
          ? (data['deadline'] as Timestamp).toDate()
          : null, // Handle nullable deadline
      status: data['status'] ?? '',
    );
  }
}
