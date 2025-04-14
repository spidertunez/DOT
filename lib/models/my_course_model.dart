import 'package:flutter/material.dart';
import 'package:hom/theme/AppColors.dart';

class MyCourseModel {
  final String title;
  final String instructor;
  final String progress;
  final double progressValue;
  final IconData icon;
  final Color color;

  const MyCourseModel({
    required this.title,
    required this.instructor,
    required this.progress,
    required this.progressValue,
    required this.icon,
    required this.color,
  });
}
