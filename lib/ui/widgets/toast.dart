import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class Toast {
  final String toastTitle;
  Toast({required this.toastTitle});

  CherryToast successToast() {
    return CherryToast(
      title: toastTitle,
      titleStyle: blackTextStyle.copyWith(fontSize: 14),
      toastDuration: const Duration(milliseconds: 2000),
      icon: Icons.done_rounded,
      iconColor: Colors.green,
      iconSize: 30,
      themeColor: kWhiteBgColor,
      toastPosition: POSITION.BOTTOM,
      autoDismiss: true,
      displayCloseButton: false,
      animationType: ANIMATION_TYPE.FROM_RIGHT,
    );
  }

  CherryToast failedToast() {
    return CherryToast(
      title: toastTitle,
      titleStyle: blackTextStyle.copyWith(fontSize: 14),
      toastDuration: const Duration(milliseconds: 3000),
      icon: Icons.close,
      iconColor: Colors.red,
      iconSize: 30,
      themeColor: kWhiteBgColor,
      toastPosition: POSITION.BOTTOM,
      autoDismiss: true,
    );
  }

  CherryToast waitingToast() {
    return CherryToast(
      title: toastTitle,
      titleStyle: blackTextStyle.copyWith(fontSize: 14),
      toastDuration: const Duration(milliseconds: 3000),
      icon: Icons.access_time,
      iconColor: Colors.blue,
      iconSize: 30,
      themeColor: kWhiteBgColor,
      toastPosition: POSITION.BOTTOM,
      autoDismiss: true,
    );
  }
}
