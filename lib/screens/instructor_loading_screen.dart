import 'package:flutter/material.dart';

import 'package:hom/screens/instructor_screen.dart';
import 'package:hom/theme/Appcolors.dart';

class LoadingInstructorScreen extends StatefulWidget {
  const LoadingInstructorScreen({super.key});

  @override
  State<LoadingInstructorScreen> createState() =>
      _LoadingInstructorScreenState();
}

class _LoadingInstructorScreenState extends State<LoadingInstructorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // Navigate to InstructorScreen after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const InstructorScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              // Animated Logo
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.navyBlue,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navyBlue.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background icon
                            Icon(
                              Icons.school,
                              size: 60,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            // Rotating icon
                            RotationTransition(
                              turns: _controller,
                              child: Icon(
                                Icons.auto_stories,
                                size: 40,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Loading Text with Typing Effect
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        const Text(
                          "Setting up your classroom",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navyBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getLoadingText(_progressAnimation.value),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Loading Progress Indicator
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _progressAnimation.value,
                              backgroundColor: AppColors.navyBlue.withOpacity(
                                0.2,
                              ),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.navyBlue,
                              ),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${(_progressAnimation.value * 100).toInt()}%",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navyBlue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLoadingText(double progress) {
    if (progress < 0.3) {
      return "Preparing your dashboard...";
    } else if (progress < 0.6) {
      return "Loading your courses...";
    } else if (progress < 0.9) {
      return "Getting student data...";
    } else {
      return "Almost ready...";
    }
  }
}
