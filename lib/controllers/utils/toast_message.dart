import 'package:flutter/material.dart';
import 'package:ctt/controllers/utils/my_color.dart';

class CustomToast {
  static void showToast(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 300,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColor.redColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(color: MyColor.whiterColor, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );

    // Add the overlay entry to the Overlay
    Overlay.of(context)!.insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
