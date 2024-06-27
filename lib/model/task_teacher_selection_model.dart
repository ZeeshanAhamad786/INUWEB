import 'package:get/get.dart';

class TaskTeacherSelectionModel{
  final String imageUrl;
  final String title;
  final String subtitle;
  final RxBool selected;
  TaskTeacherSelectionModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.selected,
});
}