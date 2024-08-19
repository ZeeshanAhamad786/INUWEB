import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class TaskTeacherSelectionModel {
  final String id;
  final String profileImageUrl;
  final String userName;
  final String userEmail;
  final RxBool selected;

  TaskTeacherSelectionModel({
    required this.id,
    required this.profileImageUrl,
    required this.userName,
    required this.userEmail,
    required this.selected,
  });

  factory TaskTeacherSelectionModel.fromJson(String id, Map<String, Object?> json) {
    return TaskTeacherSelectionModel(
      id: id,
      profileImageUrl: json["profileImageUrl"] as String,
      userName: json["userName"] as String,
      userEmail: json["userEmail"] as String,
      selected: RxBool((json["selected"] ?? false) as bool),
    );
  }

  Map<String, Object?> toJson() {
    return {
      "profileImageUrl": profileImageUrl,
      "userName": userName,
      "userEmail": userEmail,
      "selected": selected.value,
    };
  }
}
