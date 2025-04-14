import 'package:flutter/material.dart';

class OnlineClassModel {
  final String title;
  final String instructor;
  final String time;
  final String duration;
  final IconData icon;
  final Color color;

  OnlineClassModel({
    required this.title,
    required this.instructor,
    required this.time,
    required this.duration,
    required this.icon,
    required this.color,
  });
}
