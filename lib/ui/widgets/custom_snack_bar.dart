import 'package:flutter/material.dart';

class CustomSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
