import 'package:flutter/material.dart';
import 'package:hom/screens/Profile_screen.dart';
import 'package:hom/screens/HomeScreen.dart';
import 'package:hom/theme/Appcolors.dart';
import 'package:hom/routes/app_routes.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _handleNavigation(BuildContext context, int index) {
    
    onTap(index);

    if (index == currentIndex) return;

    String route;
    Map<String, dynamic>? arguments;

    switch (index) {
      case 0: // Home
        route = AppRoutes.home;
        arguments = {
          'skipLoading': true
        }; 
        break;
      case 1: // Lessons
        route = AppRoutes.savedLessons;
        break;
      case 2: // Profile
        route = AppRoutes.profile;
        break;
      default:
        route = AppRoutes.home;
        arguments = {'skipLoading': true};
    }


    Navigator.pushReplacementNamed(
      context,
      route,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.navyBlue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _handleNavigation(context, index),
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.newbeige,
          unselectedItemColor: AppColors.offWhite.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.3,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: 0.2,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
              label: "Lessons",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
