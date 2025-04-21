import 'package:flutter/material.dart';
import 'package:hom/screens/instructor_screen.dart';
import 'package:hom/theme/Appcolors.dart';

class InstructorProfile extends StatefulWidget {
  const InstructorProfile({super.key});

  @override
  State<InstructorProfile> createState() => _InstructorProfileState();
}

class _InstructorProfileState extends State<InstructorProfile> {
  int _selectedIndex = 3; // Profile selected in bottom nav
  List<String> _qualifications = [
    'Ph.D in Computer Science',
    'Master in Education Technology',
    'Certified Mobile App Developer',
    'UI/UX Design Expert'
  ];

  List<Map<String, dynamic>> _recentCourses = [
    {
      'title': 'Flutter Development',
      'rating': 4.8,
      'students': 24,
      'color': AppColors.beige,
      'image': 'assets/images/flutter_course.png', // Add actual image paths
    },
    {
      'title': 'UI Design Basics',
      'rating': 4.7,
      'students': 18,
      'color': AppColors.lightBlue,
      'image': 'assets/images/ui_course.png', // Add actual image paths
    },
    {
      'title': 'Dart Programming',
      'rating': 4.5,
      'students': 32,
      'color': AppColors.navyBlue,
      'image': 'assets/images/dart_course.png', // Add actual image paths
    },
  ];

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.edit, color: AppColors.navyBlue, size: 24),
            SizedBox(width: 8),
            Text(
              'Edit Profile',
              style: TextStyle(
                color: AppColors.darkGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.navyBlue,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.beige,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt,
                            color: Colors.white, size: 18),
                        onPressed: () {},
                        constraints: BoxConstraints(
                          minHeight: 36,
                          minWidth: 36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField(
                label: 'Full Name',
                initialValue: 'Dr. Sarah Ahmed',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Bio',
                initialValue:
                    'Experienced educator with 10+ years in mobile development teaching',
                icon: Icons.info_outline,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Email',
                initialValue: 'sarah.ahmed@email.com',
                icon: Icons.email_outlined,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.darkGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Profile updated successfully'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.beige,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text('Save Changes',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.darkGray.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: AppColors.beige),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.beige),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.beige, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.beige.withOpacity(0.5)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      controller: TextEditingController(text: initialValue),
      maxLines: maxLines,
    );
  }

  void _showAddQualificationDialog(BuildContext context) {
    final TextEditingController _qualificationController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.add_circle, color: AppColors.navyBlue, size: 24),
            SizedBox(width: 8),
            Text(
              'Add Qualification',
              style: TextStyle(
                color: AppColors.darkGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: TextField(
          controller: _qualificationController,
          decoration: InputDecoration(
            labelText: 'New Qualification',
            labelStyle: TextStyle(color: AppColors.darkGray.withOpacity(0.7)),
            prefixIcon: Icon(Icons.school_outlined, color: AppColors.beige),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.beige),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.beige, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.beige.withOpacity(0.5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.darkGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_qualificationController.text.isNotEmpty) {
                setState(() {
                  _qualifications.add(_qualificationController.text);
                });
                Navigator.pop(context);

                // Show confirmation snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Qualification added successfully'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      right: 20,
                      left: 20,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.beige,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.newbeige.withOpacity(0.5),
                  AppColors.offWhite.withOpacity(0.3),
                  AppColors.offWhite,
                ],
                stops: const [0.0, 0.3, 1.0],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // Add refresh functionality if needed
                await Future.delayed(Duration(seconds: 1));
              },
              color: AppColors.beige,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // App Bar with Back Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new,
                                  color: AppColors.navyBlue),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InstructorScreen()));
                              },
                              tooltip: 'Back to Instructor Screen',
                            ),
                          ),
                          // Edit button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () => _showEditProfileDialog(context),
                              icon: Icon(Icons.edit, color: AppColors.navyBlue),
                              tooltip: 'Edit Profile',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile Header
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      child: Column(
                        children: [
                          Hero(
                            tag: 'instructor-avatar',
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.beige, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.beige.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.navyBlue,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Dr. Sarah Ahmed",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Mobile Development Specialist",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.navyBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Stats cards
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildProfileStat("12", "Courses"),
                                _buildDivider(),
                                _buildProfileStat("256", "Students"),
                                _buildDivider(),
                                _buildProfileStat("4.8", "Rating"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // About Section
                    _buildSectionCard(
                      title: "About",
                      icon: Icons.info_outline,
                      child: Text(
                        "Dr. Sarah Ahmed is a dedicated educator with over 10 years of experience in teaching mobile application development. She specializes in Flutter, Dart, and UI/UX design principles. Her teaching approach combines theoretical knowledge with practical, real-world applications.",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),

                    // Qualifications Section
                    _buildSectionCard(
                      title: "Qualifications",
                      icon: Icons.school_outlined,
                      actionIcon: Icons.add_circle_outline,
                      onActionPressed: () =>
                          _showAddQualificationDialog(context),
                      child: Column(
                        children: _qualifications
                            .map((qualification) =>
                                _buildQualificationItem(qualification))
                            .toList(),
                      ),
                    ),

                    // Recent Courses Section
                    _buildSectionCard(
                      title: "Recent Courses",
                      icon: Icons.book_outlined,
                      child: Column(
                        children: _recentCourses
                            .map((course) => _buildCourseCard(
                                  course['title'],
                                  course['rating'],
                                  course['students'],
                                  course['color'],
                                  course['image'],
                                ))
                            .toList(),
                      ),
                    ),

                    // Contact Section
                    _buildSectionCard(
                      title: "Contact",
                      icon: Icons.contact_mail_outlined,
                      child: Column(
                        children: [
                          _buildContactItem(
                              Icons.email, "Email", "sarah.ahmed@email.com"),
                          const Divider(height: 24),
                          _buildContactItem(
                              Icons.phone, "Phone", "+1 (555) 123-4567"),
                          const Divider(height: 24),
                          _buildContactItem(Icons.access_time_filled_outlined,
                              "Office Hours", "Mon-Fri: 10:00 AM - 4:00 PM"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });

              switch (index) {
                case 0: // Home
                  // Navigate to home screen
                  break;
                case 1: // Courses
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstructorScreen()),
                  );
                  break;
                case 2: // Students
                  // TODO: Implement students screen navigation
                  break;
                case 3: // Profile
                  // Already on profile screen
                  break;
              }
            },
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: AppColors.navyBlue,
            unselectedItemColor: AppColors.darkGray.withOpacity(0.6),
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: TextStyle(fontSize: 12),
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
                label: "Courses",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: "Students",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    IconData? actionIcon,
    VoidCallback? onActionPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.beige.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          icon,
                          color: AppColors.beige,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ],
                  ),
                  if (actionIcon != null && onActionPressed != null)
                    IconButton(
                      onPressed: onActionPressed,
                      icon: Icon(
                        actionIcon,
                        color: AppColors.navyBlue,
                      ),
                      tooltip: 'Add $title',
                    ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.navyBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.darkGray.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.darkGray.withOpacity(0.2),
    );
  }

  Widget _buildQualificationItem(String qualification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.beige.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.beige,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              qualification,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.darkGray,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _qualifications.remove(qualification);
                });

                // Show removal confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Qualification removed'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        setState(() {
                          _qualifications.add(qualification);
                        });
                      },
                    ),
                    backgroundColor: AppColors.navyBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.darkGray.withOpacity(0.5),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    String title,
    double rating,
    int students,
    Color color,
    String image,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.offWhite, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to course details
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Course thumbnail with color accent
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.laptop_mac,
                      color: color,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Course details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Rating
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Students count
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: AppColors.navyBlue,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "$students",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.navyBlue,
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.darkGray.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // First, complete the missing part from the _buildContactItem method
  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.beige.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.beige,
            size: 22,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.darkGray.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
        if (label == "Email" || label == "Phone")
          IconButton(
            icon: Icon(
              Icons.content_copy,
              color: AppColors.navyBlue.withOpacity(0.6),
              size: 20,
            ),
            onPressed: () {
              // Copy to clipboard functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$label copied to clipboard'),
                  backgroundColor: AppColors.navyBlue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

// Improve the back button functionality to ensure proper navigation
  void _navigateBack() {
    Navigator.pop(context);
    // If you need to push a specific route instead of just popping:
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => InstructorScreen()),
    // );
  }

// Enhance the UI with animated back button
  Widget _buildAnimatedBackButton() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.navyBlue),
              onPressed: _navigateBack,
              tooltip: 'Back to Instructor Screen',
            ),
          ),
        );
      },
    );
  }
}
