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
    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(defaultRadius)),
      height: 55.0,
      width: double.infinity,
      child: Material(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: kTransparentColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(defaultRadius),
          splashColor: kBlueBgColor,
          onTap: onTap,
          child: Center(
            child: Text(
              textButton,
              style:
                  whiteTextStyle.copyWith(fontSize: 16.0, fontWeight: semiBold),
            ),
          ),
        ),
      ),
    );
  }
}
