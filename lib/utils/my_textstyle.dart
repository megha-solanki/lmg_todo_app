import 'package:flutter/material.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';

class MyTextStyle {
  static TextStyle bold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? black,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? black,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w600);
  }

  static TextStyle medium({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? black,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w500);
  }

  static TextStyle regular({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? black,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w400);
  }
}
