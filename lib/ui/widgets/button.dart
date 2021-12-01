import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class Button extends StatelessWidget {
  final String textButton;
  final Function() onTap;

  const Button({required this.textButton, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
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
