import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctt/controllers/utils/shared_preferences.dart';
import 'package:ctt/view/screens/coordinator_panel/coordinator_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ctt/controllers/utils/toast_message.dart';

import '../view/screens/athentications/verification_screen.dart';

class LoginController extends GetxController {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    String userDocId = MySharedPreferences.getString('userDocId');
    log(userDocId);
    if (userDocId.isNotEmpty) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userDocId).get();
      if (userDoc.exists) {
        bool isVerified = userDoc['verified'] ?? false;
        if (isVerified) {
          // Navigate to Coordinator Panel
          Get.off(() => const CoordinatorPanel());
        } else {
          // Navigate to Verification Screen
          Get.off(() => const VerificationScreen());
        }
      }
    }
  }

  Future<void> login(BuildContext context) async {
    var userEmail = userEmailController.text.trim();
    var userPassword = passwordController.text.trim();

    if (userEmail.isEmpty || userPassword.isEmpty) {
      CustomToast.showToast(context, "Email and password are required");
      return;
    } else if (!isValidEmail.hasMatch(userEmail)) {
      CustomToast.showToast(context, "Invalid email format");
      return;
    } else if (!isValidPassword.hasMatch(userPassword)) {
      CustomToast.showToast(context, "Invalid password format");
      return;
    }

    try {
      isLoading.value = true;

      // Email and password match, proceed with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      log("User signed in successfully");

      // Fetch user document from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isEmpty) {
        isLoading.value = false;
        CustomToast.showToast(context, "No user found with this email");
        return;
      }

      var userDoc = querySnapshot.docs.first;
      var userData = userDoc.data() as Map<String, dynamic>;

      // Save user document ID in SharedPreferences
      MySharedPreferences.setString("userDocId", userDoc.id);
      // Retrieve and log the stored user document ID
      String userDocId = MySharedPreferences.getString('userDocId');
      log("Stored user document ID: $userDocId");

      // Update Firestore with the new password
      await FirebaseFirestore.instance.collection('users').doc(userDoc.id).update({
        'userPassword': userPassword,
      });

      // Check verification status and navigate accordingly
      bool isVerified = userData['verified'] ?? false;
      if (isVerified) {
        // Navigate to Coordinator Panel
        Get.offAll(() => const CoordinatorPanel());
      } else {
        // Navigate to Verification Screen
        Get.offAll(() => const VerificationScreen());
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("Error signing in: $e");
      CustomToast.showToast(context, e.toString()); // Use custom toast
    }
  }
}

RegExp isValidEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

RegExp isValidPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
