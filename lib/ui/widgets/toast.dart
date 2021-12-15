import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class Toast extends StatelessWidget {
  const Toast({Key? key, required this.toastTitle}) : super(key: key);
  final String toastTitle;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  CherryToast cherryToast() {
    return CherryToast(
      title: toastTitle,
      titleStyle: blackTextStyle.copyWith(fontSize: 14),
      toastDuration: const Duration(milliseconds: 3000),
      icon: Icons.done_rounded,
      displayIcon: false,
      themeColor: kWhiteBgColor,
      toastPosition: POSITION.BOTTOM,
      autoDismiss: true,
    );
  }
}
