import 'package:flutter/material.dart';
import 'package:hom/theme/Appcolors.dart';
import 'CoursePage.dart'; // تأكد من أن هذا الملف يحتوي على الثيمات أو الإعدادات المطلوبة

// Custom Painter for the app bar background pattern
class CourseDetailPatternPainter extends CustomPainter {
  final Color color;

  CourseDetailPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw background pattern circles
    for (int i = 0; i < 8; i++) {
      double x = size.width * (i % 4) / 4;
      double y = size.height * (i ~/ 4) / 2;
      double radius = (30 + (i * 5)).toDouble();
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Draw curved pattern at the bottom
    final path = Path();
    path.moveTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 80,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final pathPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CourseDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String instructor; // Add this
  final double progress; // Add this
  // Add other fields as needed

  const CourseDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.instructor, // Add this
    required this.progress, // Add this
    // Add other required fields
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  bool _isEnrolled = false;

  // بيانات الدورة التدريبية
  final Map<String, dynamic> _courseData = {
    'author': {
      'name': 'Ahmed Hassan',
      'role': 'Senior Developer',
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      'rating': 4.9,
    },
    'stats': {
      'students': 12547,
      'reviews': 4328,
      'duration': '24 hours',
      'lessons': 42,
    },
    'description':
        'This comprehensive course will take you from beginner to advanced level. You\'ll learn through practical examples and real-world projects that will help you master the essential concepts and techniques.',
    'topics': [
      'Introduction to fundamentals',
      'Setting up your development environment',
      'Building your first application',
      'Advanced concepts and optimization',
      'Publishing your projects',
      'Professional workflows and best practices',
    ],
    'reviews': [
      {
        'user': 'Layla Ibrahim',
        'rating': 5,
        'comment':
            'This course changed my career path! The instructor explains complex topics in a simple way.',
        'date': '2 weeks ago',
        'avatar': 'https://randomuser.me/api/portraits/women/65.jpg',
      },
      {
        'user': 'Omar Samir',
        'rating': 4,
        'comment':
            'Great content and projects. I would have liked more advanced topics towards the end.',
        'date': '1 month ago',
        'avatar': 'https://randomuser.me/api/portraits/men/41.jpg',
      },
      {
        'user': 'Nour Ahmed',
        'rating': 5,
        'comment':
            'The instructor is very responsive in the Q&A section. I got all my questions answered quickly.',
        'date': '2 months ago',
        'avatar': 'https://randomuser.me/api/portraits/women/32.jpg',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _courseData.update(
        'author',
        (value) => {
              'name': widget.instructor, // Use passed instructor name
              'role': value['role'], // Keep existing role
              'image': value['image'], // Keep existing image
              'rating': value['rating'], // Keep existing rating
            });

    // Add listener to rebuild when tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = (widget.color == AppColors.beige ||
            widget.color == AppColors.lightBlue ||
            widget.color == AppColors.navyBlue ||
            widget.color == AppColors.lightTeal)
        ? AppColors.darkGray
        : AppColors.offWhite;

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          // Prevents the default glow effect on overscroll
          overscroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // App Bar مع تفاصيل الدورة
            _buildSliverAppBar(textColor),

            // تفاصيل الدورة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInstructorSection(),
                    const SizedBox(height: 25),
                    _buildCourseStats(),
                    const SizedBox(height: 25),
                    _buildTabBar(),
                  ],
                ),
              ),
            ),

            // Tab Content - Make it scrollable and dynamic height
            SliverToBoxAdapter(child: _buildTabContent()),

            // Add some padding at the bottom for better scrolling
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(textColor),
    );
  }

  Widget _buildSliverAppBar(Color textColor) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: widget.color,
      elevation: 0,
      stretch: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.offWhite),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              key: ValueKey<bool>(_isBookmarked),
              color: AppColors.offWhite,
            ),
          ),
          onPressed: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
            });
            // Show a subtle feedback
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isBookmarked
                      ? 'Added to bookmarks'
                      : 'Removed from bookmarks',
                ),
                backgroundColor: widget.color.withOpacity(0.8),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: AppColors.offWhite),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Sharing course...'),
                backgroundColor: widget.color.withOpacity(0.8),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8), // Add some padding on the right
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Animated background pattern
            CustomPaint(
              painter: CourseDetailPatternPainter(color: widget.color),
              size: Size.infinite,
            ),
            // Content with hero animation
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'course-icon-${widget.title}',
                    child: Icon(
                      widget.icon,
                      size: 50,
                      color: AppColors.offWhite,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: AppColors.offWhite,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Color.fromARGB(50, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.offWhite.withOpacity(0.9),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructorSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 50,
              height: 50,
              color: widget.color.withOpacity(0.9),
              child: Center(
                child: Text(
                  _courseData['author']['name'].substring(0, 1),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.offWhite,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _courseData['author']['name'],
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkGray,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  _courseData['author']['role'],
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: widget.color,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  _courseData['author']['rating'].toString(),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseStats() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.people,
            '${_courseData['stats']['students']}',
            'Students',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.star_border,
            '${_courseData['stats']['reviews']}',
            'Reviews',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.timer,
            _courseData['stats']['duration'],
            'Duration',
          ),
          _buildStatDivider(),
          _buildStatItem(
            Icons.book,
            '${_courseData['stats']['lessons']}',
            'Lessons',
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.beige.withOpacity(0.5),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: widget.color, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkGray,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.darkGray.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final textColor = (widget.color == AppColors.beige ||
            widget.color == AppColors.lightBlue ||
            widget.color == AppColors.mintGreen ||
            widget.color == AppColors.lightTeal)
        ? AppColors.darkGray
        : AppColors.offWhite;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.3),
              // Added spread radius
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: textColor,
        unselectedLabelColor: AppColors.navyBlue,
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'About'),
          Tab(text: 'Content'),
          Tab(text: 'Reviews'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    // Dynamic height for tab content
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: IndexedStack(
        index: _tabController.index,
        sizing: StackFit.loose,
        children: [
          Visibility(
            visible: _tabController.index == 0,
            maintainState: true,
            child: _buildAboutTab(),
          ),
          Visibility(
            visible: _tabController.index == 1,
            maintainState: true,
            child: _buildContentTab(),
          ),
          Visibility(
            visible: _tabController.index == 2,
            maintainState: true,
            child: _buildReviewsTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About This Course'),
          const SizedBox(height: 15),
          Text(
            _courseData['description'],
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.darkGray.withOpacity(0.8),
              letterSpacing: 0.2,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle('What You Will Learn'),
          const SizedBox(height: 15),
          ...(_courseData['topics'] as List).map(
            (topic) => _buildTopicItem(topic),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle('Requirements'),
          const SizedBox(height: 15),
          _buildRequirementItem('Basic programming knowledge'),
          _buildRequirementItem('Computer with minimum 8GB RAM'),
          _buildRequirementItem('Dedicated to practice regularly'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 24,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.darkGray,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildTopicItem(String topic) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: widget.color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              topic,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.darkGray.withOpacity(0.8),
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, color: widget.color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.darkGray.withOpacity(0.8),
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentTab() {
    final List<Map<String, dynamic>> sections = [
      {
        'title': 'Getting Started',
        'lessons': [
          {
            'title': 'Introduction to the Course',
            'duration': '10:15',
            'isLocked': false,
          },
          {
            'title': 'Setting Up Your Environment',
            'duration': '15:30',
            'isLocked': false,
          },
          {
            'title': 'Overview of Core Concepts',
            'duration': '12:45',
            'isLocked': false,
          },
        ],
      },
      {
        'title': 'Basic Concepts',
        'lessons': [
          {
            'title': 'Understanding the Basics',
            'duration': '18:20',
            'isLocked': false,
          },
          {
            'title': 'Your First Project',
            'duration': '25:10',
            'isLocked': true,
          },
          {
            'title': 'Common Patterns and Usage',
            'duration': '20:45',
            'isLocked': true,
          },
        ],
      },
      {
        'title': 'Advanced Techniques',
        'lessons': [
          {
            'title': 'Performance Optimization',
            'duration': '22:30',
            'isLocked': true,
          },
          {'title': 'Working with APIs', 'duration': '19:15', 'isLocked': true},
          {
            'title': 'Deployment Strategies',
            'duration': '24:00',
            'isLocked': true,
          },
        ],
      },
      {
        'title': 'Real-world Projects',
        'lessons': [
          {
            'title': 'Building a Complete Application',
            'duration': '45:10',
            'isLocked': true,
          },
          {
            'title': 'Testing and Debugging',
            'duration': '28:30',
            'isLocked': true,
          },
          {
            'title': 'Final Project and Next Steps',
            'duration': '35:45',
            'isLocked': true,
          },
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Course Content'),
          const SizedBox(height: 5),
          Text(
            '${_courseData['stats']['lessons']} lessons • ${_courseData['stats']['duration']} total',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.darkGray.withOpacity(0.7),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 20),
          ...sections.map((section) => _buildCourseSection(section)),
        ],
      ),
    );
  }

  Widget _buildCourseSection(Map<String, dynamic> section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes the divider
          colorScheme: ColorScheme.light(primary: widget.color),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          title: Text(
            section['title'],
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.darkGray,
              letterSpacing: 0.3,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              '${(section['lessons'] as List).length} lessons',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.darkGray.withOpacity(0.7),
              ),
            ),
          ),
          iconColor: widget.color,
          collapsedIconColor: AppColors.navyBlue,
          children: [
            ...((section['lessons'] as List)
                .map((lesson) => _buildLessonItem(lesson))
                .toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(Map<String, dynamic> lesson) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () {
          if (lesson['isLocked']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Please enroll in the course to access this lesson',
                ),
                backgroundColor: AppColors.darkGray,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Playing: ${lesson['title']}'),
                backgroundColor: widget.color,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: lesson['isLocked']
                ? AppColors.beige.withOpacity(0.1)
                : widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: lesson['isLocked']
                      ? AppColors.darkGray.withOpacity(0.1)
                      : widget.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  lesson['isLocked'] ? Icons.lock : Icons.play_circle_outline,
                  color: lesson['isLocked'] ? AppColors.darkGray : widget.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson['title'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: lesson['isLocked']
                            ? AppColors.darkGray.withOpacity(0.6)
                            : AppColors.darkGray,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      lesson['isLocked'] ? 'Locked' : 'Available',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: lesson['isLocked']
                            ? AppColors.darkGray.withOpacity(0.5)
                            : widget.color,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: lesson['isLocked']
                      ? AppColors.darkGray.withOpacity(0.1)
                      : widget.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  lesson['duration'],
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: lesson['isLocked']
                        ? AppColors.darkGray.withOpacity(0.6)
                        : widget.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionTitle('Student Reviews'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      "4.8",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.offWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...(_courseData['reviews'] as List).map(
            (review) => _buildReviewItem(review),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  color: widget.color.withOpacity(0.9),
                  child: Center(
                    child: Text(
                      review['user'].substring(0, 1),
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: AppColors.offWhite,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['user'],
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.darkGray,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.darkGray.withOpacity(0.7),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['comment'],
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.darkGray.withOpacity(0.8),
              letterSpacing: 0.2,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.beige.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (!_isEnrolled) {
                    setState(() {
                      _isEnrolled = true;
                    });

                    // عرض رسالة التأكيد
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully enrolled in the course!'),
                        backgroundColor: widget.color,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    // الانتظار قليلاً ثم الانتقال إلى صفحة الكورس
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoursePage(
                            title: widget.title,
                            subtitle: widget.subtitle,
                            icon: widget.icon,
                            color: widget.color,
                            lessonTitles: const [], // Adding empty list for lessonTitles
                          ),
                        ),
                      );
                    });
                  } else {
                    // إذا كان المستخدم مسجل بالفعل، الانتقال مباشرة إلى صفحة الكورس
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoursePage(
                          title: widget.title,
                          subtitle: widget.subtitle,
                          icon: widget.icon,
                          color: widget.color,
                          lessonTitles: const [], // Adding empty list for lessonTitles
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isEnrolled ? AppColors.darkGray : widget.color,
                  foregroundColor: AppColors.offWhite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  _isEnrolled ? 'Go to Course' : 'Enroll Now',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
