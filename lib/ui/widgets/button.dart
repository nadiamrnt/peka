import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class Button extends StatelessWidget {
  final String textButton;

  // ignore: prefer_typing_uninitialized_variables
  final Function() onTap;

  // ignore: use_key_in_widget_constructors
  const Button({required this.textButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 55),
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(
        textButton,
        style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
      ),
    );
  }
}
