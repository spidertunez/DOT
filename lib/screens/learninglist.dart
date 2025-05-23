import 'package:flutter/material.dart';
import 'package:hom/screens/CourseDetails.dart';
import 'package:hom/models/learning_path_model.dart';
import 'package:hom/models/course_model.dart';
import 'package:hom/theme/Appcolors.dart';

class LearningPathCoursesScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<CourseModel> courses;

  const LearningPathCoursesScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.newwbb, // Using newwbb beige for background
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: AppColors.bblue, // Using bblue for AppBar
        foregroundColor: AppColors.offWhite,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced header section with path info
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.bblue, // Using bblue for header background
              boxShadow: [
                BoxShadow(
                  color: AppColors.bblue.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.newbeige.withOpacity(
                            0.3), // Lighter beige for icon background
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.offWhite,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${courses.length} courses available',
                                style: TextStyle(
                                  color: AppColors
                                      .newbeige, // Using newbeige for text
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.play_circle_outline,
                                color: AppColors
                                    .newbeige, // Using newbeige for icon
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Title for Courses section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Text(
              "Available Courses",
              style: TextStyle(
                color: AppColors.darkGray,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Enhanced Courses list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return EnhancedCourseCard(
                    course: course,
                    color: AppColors.bblue, // Using bblue as accent color
                    index: index,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(
                            title: course.title,
                            subtitle: course.description,
                            icon: course.icon,
                            color:
                                AppColors.bblue, // Using bblue for detail page
                            instructor: course.instructor,
                            progress: course.progress,
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EnhancedCourseCard extends StatelessWidget {
  final CourseModel course;
  final Color color;
  final int index;
  final VoidCallback onTap;

  const EnhancedCourseCard({
    Key? key,
    required this.course,
    required this.color,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 3,
              shadowColor: color.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.beige.withOpacity(0.3), // Beige border
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Course Icon
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.bblue
                                    .withOpacity(0.15), // Light blue background
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                course.icon,
                                color: AppColors.bblue, // Blue icon
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Course Title and Instructor
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGray,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 14,
                                        color: AppColors.bblue
                                            .withOpacity(0.7), // Blue icon
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        course.instructor,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.bblue
                                              .withOpacity(0.7), // Blue text
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Right arrow
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.bblue
                                    .withOpacity(0.1), // Light blue background
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: AppColors.bblue, // Blue icon
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Course Description
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Text(
                          course.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGray.withOpacity(0.8),
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Course Progress
                      if (course.progress > 0)
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          decoration: BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(18),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      color:
                                          AppColors.darkGray.withOpacity(0.6),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.bblue.withOpacity(
                                          0.1), // Light blue background
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${(course.progress * 100).toInt()}%",
                                      style: TextStyle(
                                        color: AppColors.bblue, // Blue text
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Stack(
                                children: [
                                  Container(
                                    height: 6,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.beige.withOpacity(
                                          0.3), // Light beige background
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Container(
                                        height: 6,
                                        width: constraints.maxWidth *
                                            course.progress,
                                        decoration: BoxDecoration(
                                          color: AppColors
                                              .bblue, // Blue progress bar
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: AppColors.bblue
                                    .withOpacity(0.6), // Blue icon
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Not started yet",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.bblue
                                      .withOpacity(0.6), // Blue text
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
