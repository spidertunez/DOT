import 'package:flutter/material.dart';
import 'package:hom/widgets/navigation_bar.dart';
import 'package:hom/theme/Appcolors.dart';

class SavedLessons extends StatefulWidget {
  const SavedLessons({super.key});

  @override
  State<SavedLessons> createState() => _SavedLessonsState();
}

class _SavedLessonsState extends State<SavedLessons> {
  int _currentIndex = 1;
  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text(
          'Saved Lessons',
          style: TextStyle(
            color: AppColors.navyBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.navyBlue),
      ),
      body: const Center(
        child: Text('Your saved lessons will appear here'),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}
