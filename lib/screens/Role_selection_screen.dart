import 'package:flutter/material.dart';
import 'package:hom/screens/HomeScreen.dart';
import 'package:hom/animation/animation_controllers.dart';
import 'package:hom/screens/instructor_loading_screen.dart';
import 'package:hom/theme/Appcolors.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen>
    with TickerProviderStateMixin, AnimationControllerMixin {
  bool? _isStudent;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    initAnimationControllers();

    // Configure animations
    floatingController.duration = const Duration(milliseconds: 1500);
    floatingController.repeat(reverse: true);

    rotationController.duration = const Duration(milliseconds: 8000);
    rotationController.repeat();
  }

  @override
  void dispose() {
    disposeAnimationControllers();
    super.dispose();
  }

  void _navigateToHome() {
    if (_isStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role to continue'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAnimating = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => _isStudent!
              ? const HomeScreen()
              : const LoadingInstructorScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.newbeige, AppColors.offWhite],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // App name and tagline
                Center(
                  child: Column(
                    children: [
                      // Animated app name "dot"
                      AnimatedBuilder(
                        animation: nameAnimationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: nameScaleAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.navyBlue,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.navyBlue.withOpacity(0.9),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Dot",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.offWhite,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Tagline
                      const Text(
                        "Your learning journey begins here",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Role selection text
                const Text(
                  "I am a...",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGray,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Role selection cards
                Expanded(
                  child: Row(
                    children: [
                      // Student card
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isStudent = true;
                            });
                          },
                          child: AnimatedBuilder(
                            animation: floatingController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  _isStudent == true
                                      ? floatingController.value * 5
                                      : 0,
                                ),
                                child: _RoleCard(
                                  title: "Student",
                                  icon: Icons.person,
                                  description:
                                      "Access courses, track progress, and connect with instructors",
                                  isSelected: _isStudent == true,
                                  mainColor: AppColors.lightBlue,
                                  accentColor: AppColors.navyBlue,
                                  isAnimating: _isAnimating,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Instructor card
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isStudent = false;
                            });
                          },
                          child: AnimatedBuilder(
                            animation: floatingController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  _isStudent == false
                                      ? floatingController.value * 5
                                      : 0,
                                ),
                                child: _RoleCard(
                                  title: "Instructor",
                                  icon: Icons.school,
                                  description:
                                      "Create courses, mentor students, and track engagement",
                                  isSelected: _isStudent == false,
                                  mainColor: AppColors.mintGreen,
                                  accentColor: AppColors.darkGray,
                                  isAnimating: _isAnimating,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Continue button
                AnimatedOpacity(
                  opacity: _isAnimating ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedBuilder(
                    animation: colorAnimation,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: _navigateToHome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorAnimation.value,
                          foregroundColor: AppColors.offWhite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Role card widget
class _RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final bool isSelected;
  final Color mainColor;
  final Color accentColor;
  final bool isAnimating;

  const _RoleCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.mainColor,
    required this.accentColor,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isAnimating ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? mainColor.withOpacity(0.9)
              : mainColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
          border: Border.all(
            color:
                isSelected ? accentColor.withOpacity(0.5) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      isSelected ? accentColor : accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: isSelected ? AppColors.offWhite : accentColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color:
                      isSelected ? accentColor : accentColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? accentColor.withOpacity(0.8)
                      : accentColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
