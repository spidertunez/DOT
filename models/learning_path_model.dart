import 'package:flutter/material.dart';
import 'course_model.dart';

class LearningPathModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double progress;
  final List<CourseModel> courses;

  const LearningPathModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.progress,
    required this.courses,
  });
}
