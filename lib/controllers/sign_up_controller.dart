import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctt/controllers/utils/toast_message.dart';
import 'package:ctt/view/screens/athentications/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'image_picker_controller.dart';
import 'package:flutter/material.dart'; // Add this import

class SignUpController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());

  Future<void> signUp(BuildContext context) async { // Add BuildContext parameter
    var userName = userNameController.text.trim();
    var userEmail = userEmailController.text.trim();
    var userPassword = passwordController.text.trim();
    var userConfirmPassword = confirmPasswordController.text.trim();

    if (userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty || userConfirmPassword.isEmpty) {
      CustomToast.showToast(context, "All fields are required");
      return;
    } else if (!isValidEmail.hasMatch(userEmail)) {
      CustomToast.showToast(context, "Invalid email format");
      return;
    } else if (userPassword != userConfirmPassword) {
      CustomToast.showToast(context, "Passwords do not match");
      return;
    } else if (!isValidPassword.hasMatch(userPassword)) {
      CustomToast.showToast(context, "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.");
      return;
    }

    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      log("User created successfully");

      // Upload image to Firebase Storage
      String imageUrl = await uploadImageToStorage(imagePickerController.imagePath.value);

      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "userName": userName,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "userType": "coordinator",
        "verified": false,
        "profileImageUrl": imageUrl,
        "selected": false,
      });

      log("User added to Firestore successfully");
      isLoading.value = false;
      // Navigate to verification screen or any other screen
      Get.off(() => const LoginScreen());
    } catch (e) {
      isLoading.value = false;
      log("Error creating user: $e");
      CustomToast.showToast(context, e.toString()); // Use custom toast
    }
  }

  Future<String> uploadImageToStorage(String imagePath) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('images').child(fileName);
    UploadTask uploadTask = ref.putData(await getImageBytes(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<Uint8List> getImageBytes(String imagePath) async {
    if (imagePath.isEmpty) {
      throw Exception('Image path is empty');
    }
    // Use HTTP get for web to fetch image bytes
    var response = await http.get(Uri.parse(imagePath));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}

RegExp isValidEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

RegExp isValidPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
