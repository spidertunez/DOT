import 'package:flutter/material.dart';
import 'package:hom/theme/Appcolors.dart';
import 'package:hom/animation/animation_controllers.dart';
import 'package:hom/widgets/navigation_bar.dart';
import 'package:hom/widgets/chat.dart';
import 'package:hom/widgets/notifications_panel.dart';
import 'package:hom/models/notification_model.dart';
import 'package:hom/models/featured_lesson_model.dart';
import 'package:hom/models/learning_path_model.dart';
import 'package:hom/models/my_course_model.dart';
import 'package:hom/widgets/home_app_bar.dart';
import 'package:hom/widgets/section_header.dart';
import 'package:hom/widgets/learning_path_card.dart';
import 'package:hom/widgets/featured_lesson_card.dart';
import 'package:hom/widgets/loading_screen.dart';
import 'package:hom/models/course_model.dart';

class HomeScreen extends StatefulWidget {
  final bool skipLoading;

  const HomeScreen({
    super.key,
    this.skipLoading = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AnimationControllerMixin {
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _showNotifications = false;

  // Sample data
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'New Course Available',
      message: 'Check out our new course on Flutter Animation!',
      time: '5m ago',
      read: false,
      type: 'info',
      actionable: true,
      actionText: 'View Course',
    ),
    NotificationModel(
      title: 'Assignment Due',
      message: 'Your OOP Design Patterns assignment is due tomorrow',
      time: '1h ago',
      read: false,
      type: 'reminder',
      actionable: true,
      actionText: 'Submit Now',
    ),
    NotificationModel(
      title: 'Achievement Unlocked',
      message: 'You completed 5 lessons this week! Keep it up.',
      time: '2d ago',
      read: true,
      type: 'success',
      actionable: false,
    ),
  ];

  // Counter for unread notifications
  int get _unreadNotificationsCount =>
      _notifications.where((n) => !n.read).length;

  // Animation controllers for cards
  late AnimationController _cardAnimationController;
  late Animation<double> _cardSlideAnimation;
  late Animation<double> _cardRotateAnimation;

  // Data for featured lessons
  final List<FeaturedLessonModel> _featuredLessons = [
    FeaturedLessonModel(
      title: 'OOP Design Patterns',
      lessons: '9 lessons',
      rating: '4.9',
      icon: Icons.architecture,
      progress: 0.65,
      level: 'Advanced',
    ),
    FeaturedLessonModel(
      title: 'API Integration',
      lessons: '9 lessons',
      rating: '4.5',
      icon: Icons.api,
      progress: 0.3,
      level: 'Intermediate',
    ),
    FeaturedLessonModel(
      title: 'Responsive Design Patterns',
      lessons: '8 lessons',
      rating: '4.6',
      icon: Icons.widgets,
      progress: 0.0,
      level: 'Beginner',
    ),
    FeaturedLessonModel(
      title: 'State Management',
      lessons: '10 lessons',
      rating: '4.9',
      icon: Icons.layers,
      progress: 0.85,
      level: 'Advanced',
    ),
    FeaturedLessonModel(
      title: 'Advanced Animation',
      lessons: '15 lessons',
      rating: '4.7',
      icon: Icons.animation,
      progress: 0.2,
      level: 'Intermediate',
    ),
  ];

  final List<LearningPathModel> _learningPaths = [
    LearningPathModel(
      title: 'Web Development',
      subtitle: 'HTML, CSS, JavaScript',
      icon: Icons.web,
      color: AppColors.navyBlue.withOpacity(0.2),
      courses: [
        CourseModel(
          title: 'HTML Basics',
          description:
              'Learn the fundamentals of HTML including tags, attributes, forms, and semantic elements.',
          instructor: 'John Doe',
          icon: Icons.code,
          progress: 0.8,
        ),
        CourseModel(
          title: 'CSS Styling',
          description:
              'Master CSS selectors, layouts, responsiveness, and modern CSS techniques like Flexbox and Grid.',
          instructor: 'Jane Smith',
          icon: Icons.style,
          progress: 0.5,
        ),
        CourseModel(
          title: 'JavaScript Fundamentals',
          description:
              'Learn JavaScript basics including variables, functions, objects, arrays, and DOM manipulation.',
          instructor: 'Mike Johnson',
          icon: Icons.javascript,
          progress: 0.3,
        ),
        CourseModel(
          title: 'Responsive Web Design',
          description:
              'Create websites that work across all devices using media queries and mobile-first approach.',
          instructor: 'Sarah Williams',
          icon: Icons.devices,
          progress: 0.0,
        ),
        CourseModel(
          title: 'Modern CSS Frameworks',
          description:
              'Learn popular CSS frameworks like Bootstrap, Tailwind CSS, and Material UI.',
          instructor: 'Alex Chen',
          icon: Icons.grid_on,
          progress: 0.0,
        ),
      ],
      progress: 0.75,
    ),
    LearningPathModel(
      title: 'Mobile App Dev',
      subtitle: 'Flutter, React Native',
      icon: Icons.phone_android,
      color: AppColors.navyBlue.withOpacity(0.4),
      courses: [
        CourseModel(
          title: 'Flutter Basics',
          description:
              'Introduction to Flutter framework, widgets, and building your first Flutter app.',
          instructor: 'Mike Johnson',
          icon: Icons.flutter_dash,
          progress: 0.6,
        ),
        CourseModel(
          title: 'Dart Programming',
          description:
              'Learn the Dart programming language fundamentals used in Flutter development.',
          instructor: 'Emily Chen',
          icon: Icons.code,
          progress: 0.4,
        ),
        CourseModel(
          title: 'Flutter State Management',
          description:
              'Master state management solutions in Flutter apps including Provider, Bloc, and Riverpod.',
          instructor: 'David Wilson',
          icon: Icons.layers,
          progress: 0.2,
        ),
        CourseModel(
          title: 'React Native Fundamentals',
          description:
              'Build cross-platform mobile apps with React Native and JavaScript.',
          instructor: 'Jessica Lee',
          icon: Icons.phone_iphone,
          progress: 0.0,
        ),
        CourseModel(
          title: 'Mobile UI/UX Design',
          description:
              'Design beautiful and functional mobile app interfaces with focus on user experience.',
          instructor: 'Sophia Garcia',
          icon: Icons.design_services,
          progress: 0.0,
        ),
      ],
      progress: 0.45,
    ),
    LearningPathModel(
      title: 'Backend Development',
      subtitle: 'Node.js, Python, SQL',
      icon: Icons.storage,
      color: AppColors.navyBlue.withOpacity(0.4),
      courses: [
        CourseModel(
          title: 'Node.js Fundamentals',
          description:
              'Learn backend development with Node.js including Express, routing, and middleware.',
          instructor: 'Sarah Wilson',
          icon: Icons.code,
          progress: 0.7,
        ),
        CourseModel(
          title: 'RESTful API Design',
          description:
              'Build robust and scalable APIs following REST principles and best practices.',
          instructor: 'Michael Brown',
          icon: Icons.api,
          progress: 0.4,
        ),
        CourseModel(
          title: 'SQL Databases',
          description:
              'Master SQL databases including schema design, complex queries, and optimization.',
          instructor: 'Daniel Lee',
          icon: Icons.storage,
          progress: 0.3,
        ),
        CourseModel(
          title: 'NoSQL with MongoDB',
          description:
              'Learn document-based databases using MongoDB for modern web applications.',
          instructor: 'Amanda Johnson',
          icon: Icons.view_agenda,
          progress: 0.0,
        ),
        CourseModel(
          title: 'Authentication & Security',
          description:
              'Implement secure authentication systems and protect your applications from common attacks.',
          instructor: 'Robert Taylor',
          icon: Icons.security,
          progress: 0.0,
        ),
      ],
      progress: 0.3,
    ),
    LearningPathModel(
      title: 'UI/UX Design',
      subtitle: 'Figma, Adobe XD',
      icon: Icons.design_services,
      color: AppColors.navyBlue.withOpacity(0.4),
      courses: [
        CourseModel(
          title: 'Figma Basics',
          description:
              'Introduction to UI design with Figma - learn the interface, tools, and workflow.',
          instructor: 'Alex Brown',
          icon: Icons.draw,
          progress: 0.9,
        ),
        CourseModel(
          title: 'UI Design Principles',
          description:
              'Learn core UI design principles including color theory, typography, and visual hierarchy.',
          instructor: 'Olivia Wilson',
          icon: Icons.palette,
          progress: 0.6,
        ),
        CourseModel(
          title: 'Prototyping & Interaction',
          description:
              'Create interactive prototypes that simulate real user flows and interactions.',
          instructor: 'James Martin',
          icon: Icons.touch_app,
          progress: 0.4,
        ),
        CourseModel(
          title: 'UX Research Methods',
          description:
              'Learn user research techniques to inform design decisions and improve usability.',
          instructor: 'Lisa Chen',
          icon: Icons.people,
          progress: 0.0,
        ),
        CourseModel(
          title: 'Design Systems',
          description:
              'Create and maintain design systems for consistent user interfaces across products.',
          instructor: 'Thomas Jackson',
          icon: Icons.grid_view,
          progress: 0.0,
        ),
      ],
      progress: 0.6,
    ),
    LearningPathModel(
      title: 'Data Science',
      subtitle: 'Python, R, Tableau',
      icon: Icons.analytics,
      color: AppColors.navyBlue.withOpacity(0.4),
      courses: [
        CourseModel(
          title: 'Python for Data Science',
          description:
              'Learn Python programming fundamentals for data analysis and machine learning.',
          instructor: 'David Lee',
          icon: Icons.code,
          progress: 0.5,
        ),
        CourseModel(
          title: 'Data Visualization',
          description:
              'Create effective visualizations to communicate insights using Python libraries and Tableau.',
          instructor: 'Emma Thompson',
          icon: Icons.bar_chart,
          progress: 0.3,
        ),
        CourseModel(
          title: 'Statistical Analysis',
          description:
              'Learn statistical methods and hypothesis testing for data-driven decision making.',
          instructor: 'Ryan Martinez',
          icon: Icons.functions,
          progress: 0.2,
        ),
        CourseModel(
          title: 'Machine Learning Basics',
          description:
              'Introduction to machine learning algorithms, models, and applications.',
          instructor: 'Jennifer Wilson',
          icon: Icons.psychology,
          progress: 0.0,
        ),
        CourseModel(
          title: 'Big Data Processing',
          description:
              'Work with large datasets using tools like Hadoop, Spark, and data warehouses.',
          instructor: 'Andrew Davis',
          icon: Icons.backup_table,
          progress: 0.0,
        ),
      ],
      progress: 0.2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    initAnimationControllers();

    // Configure animations
    floatingController.duration = const Duration(milliseconds: 1500);
    floatingController.repeat();

    rotationController.duration = const Duration(milliseconds: 8000);
    rotationController.repeat();

    // Card animation setup
    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _cardSlideAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _cardRotateAnimation = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _cardAnimationController.repeat(reverse: true);

    
    if (widget.skipLoading) {
      _isLoading = false;
    } else {
    
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  // Toggle notifications visibility
  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  // Mark notification as read
  void _markAsRead(int index) {
    setState(() {
      _notifications[index] = _notifications[index].copyWith(read: true);
    });
  }

  // Mark all notifications as read
  void _markAllAsRead() {
    setState(() {
      _notifications.replaceRange(
        0,
        _notifications.length,
        _notifications.map((n) => n.copyWith(read: true)).toList(),
      );
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    disposeAnimationControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingScreen();
    }

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Simple gradient background
          Container(decoration: const BoxDecoration(color: AppColors.newwbb)),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(
                    notifications: _notifications,
                    onNotificationPressed: _toggleNotifications,
                    onProfilePressed: () {},
                    unreadNotificationsCount: _unreadNotificationsCount,
                    nameScaleAnimation: nameScaleAnimation,
                    nameSlideAnimation: nameSlideAnimation,
                  ),

                  // Learning Paths Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'Learning Paths',
                          subtitle: 'Choose your path to success',
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _learningPaths.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index == _learningPaths.length - 1
                                      ? 0
                                      : 16,
                                ),
                                child: LearningPathCard(
                                  path: _learningPaths[index],
                                  slideAnimation: _cardSlideAnimation,
                                  rotateAnimation: _cardRotateAnimation,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Featured Lessons Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'Featured Lessons',
                          subtitle: 'Popular courses to get started',
                        ),
                        const SizedBox(height: 16),
                        ..._featuredLessons.map(
                          (lesson) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FeaturedLessonCard(lesson: lesson),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // My Courses Section
                ],
              ),
            ),
          ),

          // Show notifications panel when toggled
          if (_showNotifications)
            NotificationsPanel(
              notifications: _notifications,
              markAsRead: _markAsRead,
              toggleNotifications: _toggleNotifications,
              markAllAsRead: _markAllAsRead,
            ),
        ],
      ),

      // Chat floating action button
      floatingActionButton: AnimatedBuilder(
        animation: colorAnimation,
        builder: (context, child) {
          return AnimatedScale(
            scale: _isLoading ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1.1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ChatDialog(),
                      );
                    },
                    backgroundColor: colorAnimation.value,
                    label: const Text(
                      "AI Assistant",
                      style: TextStyle(
                        color: AppColors.offWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: const Icon(Icons.chat, color: AppColors.offWhite),
                  ),
                );
              },
            ),
          );
        },
      ),

      // Bottom navigation bar
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
