import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FilePickerController extends GetxController {
  var fileName = ''.obs;
  RxBool loading = false.obs;
  Uint8List? fileBytes;
  List<String> fileDocIds = [];
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.name.isNotEmpty) {
        fileName.value = result.files.single.name;
        fileBytes = result.files.single.bytes;
      } else {
        fileName.value = 'No file selected';
      }
    } catch (e) {
      fileName.value = 'Error picking file';
      print('Error picking file: $e');
    }
  }

  Future<bool> uploadFile() async {
    if (fileName.value.isEmpty || fileBytes == null) {
      print('No file selected or file bytes are null');
      return false;
    }
    loading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user is logged in');
        return false;
      }

      String userId = user.uid;
      String filePath = 'files/$userId/${fileName.value}';

      final ref = _storage.ref().child(filePath);
      final uploadTask = ref.putData(fileBytes!);
      final snapshot = await uploadTask.whenComplete(() => {});
      final fileUrl = await snapshot.ref.getDownloadURL();

      DocumentReference docRef = await _firestore.collection('files').add({
        'fileName': fileName.value,
        'fileUrl': fileUrl,
        'userId': userId,
      });

      fileDocIds.add(docRef.id);

      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      print('Error uploading file: $e');
      return false;
    } finally {
      loading.value = false;
    }
  }
}
