import 'package:flutter/material.dart';

class FeaturedLessonModel {
  final String title;
  final String lessons;
  final String rating;
  final IconData icon;
  final double progress;
  final String level;

  FeaturedLessonModel({
    required this.title,
    required this.lessons,
    required this.rating,
    required this.icon,
    required this.progress,
    required this.level,
  });
}
