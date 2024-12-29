import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class TopSnackBar {
  // Fungsi umum
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black,
    IconData icon = Icons.info_outline,
    Duration duration = const Duration(
      seconds: 3,
    ),
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: backgroundColor,
      flushbarPosition: position,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    ).show(context);
  }
}
