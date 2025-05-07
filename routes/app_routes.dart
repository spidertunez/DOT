import 'package:flutter/material.dart';
import 'package:hom/loginAndSignup/loginScreen.dart';
import 'package:hom/loginAndSignup/signupScreen.dart';
import 'package:hom/onboard/onboard_screen.dart';
import 'package:hom/splash/splashscreen.dart';
import 'package:hom/screens/HomeScreen.dart';
import 'package:hom/screens/Profile_screen.dart';
import 'package:hom/screens/CourseDetails.dart';
import 'package:hom/screens/CoursePage.dart';
import 'package:hom/screens/Role_selection_screen.dart';
import 'package:hom/screens/chatbot.dart';
import 'package:hom/screens/instructor_screen.dart';
import 'package:hom/screens/learninglist.dart';
import 'package:hom/screens/LessonPage.dart';
import 'package:hom/screens/youtubeList.dart';
import 'package:hom/screens/SavedLessons.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String courseDetails = '/course-details';
  static const String coursePage = '/course-page';
  static const String roleSelection = '/role-selection';
  static const String chatbot = '/chatbot';
  static const String instructor = '/instructor';
  static const String videoLesson = '/video-lesson';
  static const String learningList = '/learning-list';
  static const String lessonPage = '/lesson-page';
  static const String youtubeList = '/youtube-list';
  static const String savedLessons = '/saved-lessons';
  static const String back = 'back';

  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, home);
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(userType: 0),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(userType: 0),
        );
      case home:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            skipLoading: args?['skipLoading'] ?? false,
          ),
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case courseDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CourseDetailPage(
            title: args?['title'] ?? 'Course Title',
            subtitle: args?['subtitle'] ?? 'Course Subtitle',
            icon: args?['icon'] ?? Icons.book,
            color: args?['color'] ?? Colors.blue,
            instructor: args?['instructor'] ?? 'Instructor Name',
            progress: args?['progress'] ?? 0.0,
          ),
        );
      case coursePage:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CoursePage(
            title: args?['title'] ?? 'Course Title',
            subtitle: args?['subtitle'] ?? 'Course Subtitle',
            icon: args?['icon'] ?? Icons.book,
            color: args?['color'] ?? Colors.blue,
            lessonTitles: (args?['lessonTitles'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                const <String>[],
          ),
        );
      case roleSelection:
        return MaterialPageRoute(
          builder: (_) => const UserSelectionScreen(isLogin: true),
        );
      case chatbot:
        return MaterialPageRoute(
          builder: (_) => ChatScreen(),
        );
      case instructor:
        return MaterialPageRoute(
          builder: (_) => const InstructorScreen(),
        );

      case learningList:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LearningPathCoursesScreen(
            title: args?['title'] ?? 'Learning Path',
            subtitle: args?['subtitle'] ?? 'Available Courses',
            icon: args?['icon'] ?? Icons.school,
            color: args?['color'] ?? Colors.blue,
            courses: args?['courses'] ?? [],
          ),
        );
      case lessonPage:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LessonDetailPage(
            title: args?['title'] ?? 'Lesson Title',
            subtitle: args?['subtitle'] ?? 'Lesson Subtitle',
            lessons: args?['lessons'] ?? '0 lessons',
            rating: args?['rating'] ?? '0.0',
            icon: args?['icon'] ?? Icons.book,
            color: args?['color'] ?? Colors.blue,
            lessonTitles: args?['lessonTitles'] ?? const [],
          ),
        );
      case youtubeList:
        return MaterialPageRoute(
          builder: (_) => const YouTubePlaylistScreen(),
        );
      case savedLessons:
        return MaterialPageRoute(
          builder: (_) => SavedLessons(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
