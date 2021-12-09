import 'package:flutter/material.dart';

import '../../common/styles.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final String imageAsset;
  final Function() onTap;

  // ignore: use_key_in_widget_constructors
  const ProfileOption(
      {required this.title, required this.imageAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          //image icon
          Container(
            width: 32.0,
            height: 32.0,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: kBlueBgColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(
              'assets/icons/$imageAsset',
              fit: BoxFit.cover,
            ),
          ),
          //title
          const SizedBox(width: 20),
          Text(
            title,
            style: greyTextStyle.copyWith(
              fontSize: 16.0,
              fontWeight: regular,
            ),
          )
        ],
      ),
    );
  }
}
