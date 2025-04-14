import 'package:flutter/material.dart';
import 'package:hom/models/online_class_model.dart';
import 'package:hom/theme/AppColors.dart';

class OnlineClassCard extends StatelessWidget {
  final OnlineClassModel classInfo;

  const OnlineClassCard({super.key, required this.classInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: classInfo.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(classInfo.icon, color: classInfo.color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classInfo.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGray,
                      ),
                    ),
                    Text(
                      classInfo.instructor,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGray.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.darkGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    classInfo.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGray.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.timer, size: 16, color: AppColors.darkGray),
                  const SizedBox(width: 4),
                  Text(
                    classInfo.duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGray.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement join class functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: classInfo.color,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Join Class',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
