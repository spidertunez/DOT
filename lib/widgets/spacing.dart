import 'package:flutter/material.dart';

// تحديد قيم تباعد قياسية لتوحيد التصميم
class Spacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // تنفيذ نظام تباعد متناسق
  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const double listItemSpacing = md;
}