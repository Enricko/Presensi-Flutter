import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Alerts {
  static showMessage(String message, BuildContext context) {
    // print("item deleted!");
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 2),
      curve: Curves.elasticOut,
    );
  }

  static showAlertYesNo({required String title, required String content, required VoidCallback onPressYes,
    required VoidCallback onPressNo, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // judul
          title: Text(title),
          // isi pesan
          content: Text(content),
          actions: [
            // tombel yes
            TextButton(
              onPressed: onPressYes,
              child: Text('Yes'),
            ),
            //tombol no
            TextButton(
              onPressed: onPressNo,
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }


}