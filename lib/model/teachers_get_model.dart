import 'package:cloud_firestore/cloud_firestore.dart';

class TeachersGetModel {
  final String id;
  final String profileImageUrl;
  final String userName;
  final String userEmail;
  final String? userTitleName;
  DateTime? deadline;

  TeachersGetModel({
    required this.id,
    required this.profileImageUrl,
    required this.userName,
    required this.userEmail,
    required this.userTitleName,
     this.deadline,

  });

  factory TeachersGetModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TeachersGetModel(
      id: doc.id,
      profileImageUrl: data['profileImageUrl'] ?? '',
      userName: data['userName'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userTitleName: data['userTitleName'] ?? '',
      deadline: data['deadline'] != null
          ? (data['deadline'] as Timestamp).toDate()
          : null,
    );
  }
}
