import 'package:flutter/material.dart';
import 'package:hom/theme/AppColors.dart';

// تحسين نظام الألوان مع تعريف ألوان إضافية للتباين
class AppTheme {
  static const double borderRadius = 16.0;
  // تسريع الرسوم المتحركة
  static const Duration animationDuration = Duration(
    milliseconds: 150,
  ); // تم تقليل المدة من 250 إلى 150

  // تحديد تأثيرات الظلال بشكل موحد
  static List<BoxShadow> getShadow({double opacity = 0.15}) {
    return [
      BoxShadow(
        color: AppColors.darkGray.withOpacity(opacity),
        offset: const Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }
}
