import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

mixin AnimationControllerMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController floatingController;
  late AnimationController rotationController;
  late AnimationController fadeController;
  late AnimationController cardRotationController;
  late AnimationController nameAnimationController;
  late Animation<Color?> colorAnimation;
  late Animation<double> nameScaleAnimation;
  late Animation<double> nameSlideAnimation;

  void initAnimationControllers() {
    // For floating elements
    floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // For rotating elements
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // For card rotation animation
    cardRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // For fading elements
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Animation controller for the name
    nameAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Animations for the name
    nameScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: nameAnimationController, curve: Curves.easeInOut),
    );

    nameSlideAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: nameAnimationController, curve: Curves.easeInOut),
    );

    // For color changing elements
    colorAnimation = ColorTween(
      begin: AppColors.navyBlue,
      end: AppColors.beige,
    ).animate(fadeController);
  }

  void disposeAnimationControllers() {
    floatingController.dispose();
    rotationController.dispose();
    fadeController.dispose();
    cardRotationController.dispose();
    nameAnimationController.dispose();
  }
}
