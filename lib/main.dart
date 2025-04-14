import 'package:flutter/material.dart';
import 'package:hom/screens/Role_selection_screen.dart';

import 'theme/AppColors.dart';

void main() {
  runApp(const CodingLearningApp());
}

class CodingLearningApp extends StatelessWidget {
  const CodingLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.navyBlue,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.offWhite,
            letterSpacing: 0.5,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.offWhite,
            letterSpacing: 0.3,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.offWhite,
            letterSpacing: 0.2,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.offWhite,
            letterSpacing: 0.2,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.offWhite,
            letterSpacing: 0.1,
          ),
        ),
      ),
      home: UserSelectionScreen(),
    );
  }
}
