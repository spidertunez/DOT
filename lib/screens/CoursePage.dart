import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

class CoursePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const CoursePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        (color == AppColors.beige ||
                color == AppColors.lightBlue ||
                color == AppColors.lightTeal ||
                color == AppColors.mintGreen)
            ? AppColors.darkGray
            : AppColors.offWhite;

    // قائمة بعناوين مناسبة للدروس حسب نوع الكورس
    final List<String> lessonTitles = _getLessonTitles(title);

    return Scaffold(
      body: Stack(
        children: [
          // خلفية متدرجة محسنة مع تأثير تموج
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.8),
                  AppColors.navyBlue,
                  AppColors.offWhite,
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // شريط التطبيق مع زر الرجوع
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.share, color: textColor),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border, color: textColor),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // رأس الكورس مع تصميم محسن
                // رأس الكورس مع تصميم محسن وأنيق
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // أيقونة الكورس مع تأثير ثلاثي الأبعاد وظل
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(icon, size: 55, color: textColor),
                      ),
                      const SizedBox(height: 24),

                      // عنوان الكورس مع تأثيرات نصية محسنة
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            letterSpacing: 0.5,
                            fontFamily: 'Montserrat',
                            height: 1.2,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 5.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // وصف الكورس مع تصميم محسن
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor.withOpacity(0.95),
                            letterSpacing: 0.3,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // معلومات إضافية بتصميم محسن
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.beige.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.beige.withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: textColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "8 weeks",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.beige.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.beige.withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 18, color: textColor),
                                const SizedBox(width: 8),
                                Text(
                                  "4.8 (258)",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Course content with enhanced design
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.newbeige,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Course Content",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGray,
                                letterSpacing: 0.3,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "7 lessons",
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              // Using custom lesson titles
                              String lessonTitle =
                                  (index < lessonTitles.length)
                                      ? lessonTitles[index]
                                      : "Lesson ${index + 1}: Introduction to $title";

                              // Setting lesson duration in a varied and logical manner
                              String duration = _getLessonDuration(index);

                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.beige.withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: color,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lessonTitle,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkGray,
                                              letterSpacing: 0.2,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 14,
                                                color: AppColors.darkGray
                                                    .withOpacity(0.6),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                duration,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.darkGray
                                                      .withOpacity(0.6),
                                                  letterSpacing: 0.1,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      index < 2
                                                          ? Colors.green
                                                              .withOpacity(0.1)
                                                          : color.withOpacity(
                                                            0.1,
                                                          ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  index < 2
                                                      ? "Completed"
                                                      : "New",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        index < 2
                                                            ? Colors.green
                                                            : color,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            (index < 2)
                                                ? Colors.green.withOpacity(0.1)
                                                : color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(
                                        index < 2
                                            ? Icons.check
                                            : Icons.play_arrow,
                                        color: index < 2 ? Colors.green : color,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: color,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        label: Text(
          "Start Learning Now",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            fontSize: 16,
          ),
        ),
        icon: Icon(Icons.play_arrow, color: textColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Function to create custom lesson titles based on course type
  List<String> _getLessonTitles(String courseTitle) {
    Map<String, List<String>> courseLessons = {
      'Programming': [
        'Programming Basics and Languages',
        'Data Structures and Algorithms',
        'Object-Oriented Programming (OOP)',
        'Databases and SQL',
        'User Interface Development',
        'Software Testing and Quality Assurance',
        'Comprehensive Application Project',
      ],
      'Design': [
        'Design Fundamentals and Color Theory',
        'Using Professional Design Software',
        'User Interface Design (UI)',
        'User Experience (UX)',
        'Branding and Identity Design',
        'Responsive Design and Applications',
        'Integrated Design Project',
      ],
      'Marketing': [
        'Digital Marketing Fundamentals',
        'Social Media Strategies',
        'Search Engine Optimization (SEO)',
        'Email Marketing',
        'Paid Advertising and Ad Campaigns',
        'Data Analysis and Performance Reports',
        'Comprehensive Marketing Strategy',
      ],
      'Languages': [
        'Grammar and Pronunciation Basics',
        'Common Vocabulary and Phrases',
        'Conversation and Listening Skills',
        'Advanced Reading and Writing',
        'Culture and Cross-cultural Communication',
        'Preparation for Standardized Tests',
        'Advanced Conversation and Final Project',
      ],
      'Business': [
        'Business Management Fundamentals',
        'Strategic Planning and Model Building',
        'Marketing and Business Development',
        'Financial Management and Accounting',
        'Human Resources Management',
        'Entrepreneurship and Innovation',
        'Case Study and Practical Application',
      ],
    };

    // Attempt to find lesson titles that match the course title
    for (var key in courseLessons.keys) {
      if (courseTitle.contains(key)) {
        return courseLessons[key]!;
      }
    }

    // Default titles if no match is found
    return [
      'Introduction to $courseTitle',
      'Basic Concepts',
      'Advanced Techniques',
      'Case Studies and Practical Applications',
      'Strategies and Tools for $courseTitle',
      'Challenges and Solutions in the Field',
      'Final Applied Project',
    ];
  }

  // Function to create varied and logical durations for lessons
  String _getLessonDuration(int index) {
    List<String> durations = [
      "45 minutes",
      "60 minutes",
      "30 minutes",
      "75 minutes",
      "50 minutes",
      "40 minutes",
      "90 minutes",
    ];

    return durations[index % durations.length];
  }
}

// Enhanced Lesson Detail Page
class LessonDetailPage extends StatelessWidget {
  final String title;
  final String lessons;
  final String rating;
  final IconData icon;

  const LessonDetailPage({
    super.key,
    required this.title,
    required this.lessons,
    required this.rating,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Creating appropriate titles and descriptions for educational modules
    List<Map<String, String>> modules = _getModuleDetails(
      title,
      int.parse(lessons.split(' ')[0]),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Enhanced gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.navyBlue,
                  AppColors.darkGray,
                  AppColors.beige,
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced app bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.offWhite,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.beige,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: AppColors.darkGray,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating,
                                  style: const TextStyle(
                                    color: AppColors.darkGray,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(
                              Icons.share,
                              color: AppColors.offWhite,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: AppColors.offWhite,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Lesson header with enhanced design
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(icon, color: AppColors.offWhite, size: 40),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: AppColors.offWhite,
                          letterSpacing: 0.5,
                          fontFamily: 'Montserrat',
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3.0,
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        lessons,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: AppColors.beige,
                          letterSpacing: 0.3,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.lightBlue.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: AppColors.offWhite,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "12 hours total",
                                  style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.lightBlue.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: AppColors.offWhite,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "750 Students",
                                  style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 15,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Lesson Units",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGray,
                                letterSpacing: 0.3,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.navyBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.play_circle_outline,
                                    size: 16,
                                    color: AppColors.navyBlue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${int.parse(lessons.split(' ')[0])} Units",
                                    style: const TextStyle(
                                      color: AppColors.navyBlue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Complete 2 out of ${int.parse(lessons.split(' ')[0])} units",

                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGray.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // شريط التقدم
                        Container(
                          height: 8,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 2 / int.parse(lessons.split(' ')[0]),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                            itemCount: int.parse(lessons.split(' ')[0]),
                            itemBuilder: (context, index) {
                              final moduleInfo =
                                  modules[index % modules.length];
                              final bool isCompleted = index < 2;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.beige.withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  border:
                                      isCompleted
                                          ? Border.all(
                                            color: Colors.green.withOpacity(
                                              0.3,
                                            ),
                                            width: 1.5,
                                          )
                                          : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color:
                                            isCompleted
                                                ? Colors.green.withOpacity(0.15)
                                                : AppColors.lightBlue
                                                    .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color:
                                                isCompleted
                                                    ? Colors.green
                                                    : AppColors.navyBlue,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            moduleInfo['title'] ??
                                                "Module ${index + 1}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkGray,
                                              letterSpacing: 0.2,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            moduleInfo['description'] ??
                                                "Description for learning module ${index + 1}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.darkGray
                                                  .withOpacity(0.7),
                                              letterSpacing: 0.1,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 14,
                                                color: AppColors.darkGray
                                                    .withOpacity(0.6),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                moduleInfo['duration'] ??
                                                    "30 minutes",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.darkGray
                                                      .withOpacity(0.6),
                                                  letterSpacing: 0.1,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      isCompleted
                                                          ? Colors.green
                                                              .withOpacity(0.1)
                                                          : AppColors.navyBlue
                                                              .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  isCompleted
                                                      ? "Completed"
                                                      : "New",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        isCompleted
                                                            ? Colors.green
                                                            : AppColors
                                                                .navyBlue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            isCompleted
                                                ? Colors.green.withOpacity(0.1)
                                                : AppColors.lightBlue
                                                    .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(
                                        isCompleted
                                            ? Icons.check
                                            : Icons.play_arrow,
                                        color:
                                            isCompleted
                                                ? Colors.green
                                                : AppColors.navyBlue,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navyBlue,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_filled,
                color: AppColors.offWhite,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                "Continue Learning",
                style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create module details based on lesson title
  List<Map<String, String>> _getModuleDetails(
    String lessonTitle,
    int moduleCount,
  ) {
    Map<String, List<Map<String, String>>> lessonModules = {
      'Programming Basics': [
        {
          'title': 'Introduction to Computer Science',
          'description':
              'Learn the fundamentals of computer science and how computers work',
          'duration': '45 minutes',
        },
        {
          'title': 'Variables and Data Types',
          'description': 'Learn how to store and use data in programs',
          'duration': '50 minutes',
        },
        {
          'title': 'Conditional Structures',
          'description': 'How to make programming decisions using if and else',
          'duration': '35 minutes',
        },
        {
          'title': 'Loops',
          'description':
              'Learn how to repeat operations using for and while loops',
          'duration': '40 minutes',
        },
        {
          'title': 'Functions',
          'description': 'How to organize code using functions and reuse it',
          'duration': '55 minutes',
        },
        {
          'title': 'Basic Data Structures',
          'description': 'Introduction to arrays, lists, and sets',
          'duration': '60 minutes',
        },
        {
          'title': 'Applied Project',
          'description': 'Apply learned concepts in building a simple program',
          'duration': '90 minutes',
        },
      ],
      'Graphic Design': [
        {
          'title': 'Introduction to Graphic Design',
          'description': 'Learn the basics and history of graphic design',
          'duration': '40 minutes',
        },
        {
          'title': 'Color Theory',
          'description':
              'Understanding color relationships and psychological impact',
          'duration': '50 minutes',
        },
        {
          'title': 'Design with Adobe Photoshop',
          'description': 'Learn the basics of using Photoshop',
          'duration': '65 minutes',
        },
        {
          'title': 'Typography',
          'description':
              'Learn the fundamentals of fonts and text formatting in design',
          'duration': '45 minutes',
        },
        {
          'title': 'Logo Design',
          'description': 'How to design professional and meaningful logos',
          'duration': '55 minutes',
        },
        {
          'title': 'Social Media Design',
          'description':
              'Creating effective designs for social media platforms',
          'duration': '50 minutes',
        },
        {
          'title': 'Final Project',
          'description':
              'Apply acquired skills in a comprehensive design project',
          'duration': '80 minutes',
        },
      ],
    };

    // Try to find module details matching the lesson title
    for (var key in lessonModules.keys) {
      if (lessonTitle.contains(key)) {
        // Return the requested number of modules
        List<Map<String, String>> result = [];
        for (int i = 0; i < moduleCount; i++) {
          if (i < lessonModules[key]!.length) {
            result.add(lessonModules[key]![i]);
          } else {
            // Add additional modules if the requested count is greater than available
            result.add({
              'title': 'Additional Module ${i + 1}',
              'description': 'Additional content related to $lessonTitle',
              'duration': '${30 + (i * 5 % 30)} minutes',
            });
          }
        }
        return result;
      }
    }

    // Default modules if no match is found
    List<Map<String, String>> defaultModules = [];
    for (int i = 0; i < moduleCount; i++) {
      defaultModules.add({
        'title': 'Module ${i + 1}: ${_getGenericTitle(i, lessonTitle)}',
        'description': _getGenericDescription(i, lessonTitle),
        'duration': '${30 + (i * 10 % 30)} minutes',
      });
    }

    return defaultModules;
  }

  // Helper function to create generic titles
  String _getGenericTitle(int index, String subject) {
    List<String> prefixes = [
      'Introduction to',
      'Fundamentals of',
      'Strategies for',
      'Advanced Techniques in',
      'Practical Applications of',
      'Analysis and Study of',
      'Applied Project in',
    ];

    return '${prefixes[index % prefixes.length]} $subject';
  }

  // Helper function to create generic descriptions
  String _getGenericDescription(int index, String subject) {
    List<String> descriptions = [
      'Learn the basic concepts and key principles in this field',
      'Explore the techniques and tools used in this field',
      'Learn advanced strategies and solutions for common challenges',
      'Study practical applications and implement them step by step',
      'Analyze case studies and extract learned lessons',
      'Build advanced skills and apply them in real-world projects',
      'Develop a comprehensive project that combines all learned concepts',
    ];

    return descriptions[index % descriptions.length];
  }
}
