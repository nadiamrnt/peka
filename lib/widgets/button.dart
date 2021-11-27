import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class Button extends StatelessWidget {
  final String textButton;

  // ignore: use_key_in_widget_constructors
  const Button({required this.textButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        width: 312.0,
        height: 55.0,
        child: Center(
          child: Text(
            textButton,
            style:
                whiteTextStyle.copyWith(fontSize: 16.0, fontWeight: semiBold),
          ),
        ),
      ),
    );
  }
}
