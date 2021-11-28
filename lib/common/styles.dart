import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;
double defaultRadius = 17.0;
double defaultRadiusTextField = 8.0;

Color kPrimaryColor = const Color(0xff3A6CA9);
Color kBlackColor = const Color(0xff1F344D);
Color kWhiteColor = const Color(0xffFFFFFF);
Color kWhiteBgColor = const Color(0xffFAFAFA);
Color kGreyColor = const Color(0xff7D90A4);
Color kGreyBgColor = const Color(0xffF8F8F8);
Color kGreyHintColor = const Color(0xffAFB2B9);
Color kPinkBgColor = const Color(0xffFDEFED);
Color kBlueBgColor = const Color(0xffF2F8FF);
Color kTransparentColor = Colors.transparent;

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greyHintTextStyle = GoogleFonts.poppins(
  color: kGreyHintColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
