import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  static const _family = "Inter";

  static TextStyle get text25Reg => TextStyle(
        fontFamily: _family,
        fontSize: 25.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text18SimBold => TextStyle(
        fontFamily: _family,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text16Reg => TextStyle(
        fontFamily: _family,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text14Reg => TextStyle(
        fontFamily: _family,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text14Bold => TextStyle(
        fontFamily: _family,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get text30SimBold => TextStyle(
        fontFamily: _family,
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text12Reg => TextStyle(
        fontFamily: _family,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text10Reg => TextStyle(
        fontFamily: _family,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text18Reg => TextStyle(
        fontFamily: _family,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text20Mid => TextStyle(
        fontFamily: _family,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text12SimBold => TextStyle(
        fontFamily: _family,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text15Mid => TextStyle(
        fontFamily: _family,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      );
}
