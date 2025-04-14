import 'package:flutter/material.dart';
import 'package:hom/theme/AppColors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.newbeige, AppColors.offWhite],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.3),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.beige.withOpacity(0.4),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.navyBlue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 60,
                      color: AppColors.navyBlue,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              "Loading your learning journey...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppColors.offWhite,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.beige,
                    ),
                    minHeight: 8,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
