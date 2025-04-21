import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String description;
  final String instructor;
  final IconData icon;
  final double progress;
  final List<String> lessons;
  final List<String> resources;

  const CourseModel({
    required this.title,
    required this.description,
    required this.instructor,
    required this.icon,
    this.progress = 0.0,
    this.lessons = const [],
    this.resources = const [],
  });
}
