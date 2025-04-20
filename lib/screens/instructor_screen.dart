// File: instructor_screen.dart
import 'package:flutter/material.dart';
import 'package:hom/screens/Instructor_profile%20.dart';
import 'package:hom/theme/Appcolors.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({super.key});

  @override
  State createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State {
  int _selectedIndex = 0;
  bool _showNotifications = false;
  String? _selectedPdfFileName;
  String? _selectedVideoFileName;
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  String _fileUploadStatus = '';
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Course Enrollment',
      'message': '3 students enrolled in Flutter Development',
      'time': '2h ago',
      'read': false,
    },
    {
      'title': 'Assignment Submitted',
      'message': '15 submissions for UI Design Basics',
      'time': '5h ago',
      'read': false,
    },
    {
      'title': 'Course Update',
      'message': 'New content added to Web Development course',
      'time': '1d ago',
      'read': true,
    },
  ];

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['read'] = true;
    });
  }

  // Method to show course creation dialog with file upload UI
  void _showNewCourseDialog(BuildContext context) {
    setState(() {
      _selectedPdfFileName = null;
      _selectedVideoFileName = null;
      _fileUploadStatus = '';
      _courseNameController.clear();
      _courseDescriptionController.clear();
    });
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Create New Course'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _courseNameController,
                    decoration: InputDecoration(
                      labelText: 'Course Title',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.beige),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.beige),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _courseDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Course Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.beige),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.beige),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Course Materials',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // PDF Upload Section (UI only)
                  InkWell(
                    onTap: () {
                      // Just update UI with mock file selection
                      setDialogState(() {
                        _selectedPdfFileName = 'course_materials.pdf';
                        _fileUploadStatus =
                            'PDF file selected: course_materials.pdf';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.beige),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.upload_file, color: AppColors.beige),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedPdfFileName != null
                                  ? 'PDF: $_selectedPdfFileName'
                                  : 'Upload PDF',
                              style: TextStyle(
                                color: AppColors.darkGray,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Video Upload Section (UI only)
                  InkWell(
                    onTap: () {
                      // Just update UI with mock file selection
                      setDialogState(() {
                        _selectedVideoFileName = 'course_intro.mp4';
                        _fileUploadStatus =
                            'Video file selected: course_intro.mp4';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.beige),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.video_library, color: AppColors.beige),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedVideoFileName != null
                                  ? 'Video: $_selectedVideoFileName'
                                  : 'Upload Video',
                              style: TextStyle(
                                color: AppColors.darkGray,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_fileUploadStatus.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        _fileUploadStatus,
                        style: TextStyle(
                          color: AppColors.beige,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.darkGray),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle course creation (UI feedback only)
                  _createCourseWithFiles(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.beige,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Create Course'),
              ),
            ],
          );
        },
      ),
    );
  }

  // Method to handle the creation of a course (UI feedback only)
  void _createCourseWithFiles(BuildContext context) {
    // Show a success notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Course "${_courseNameController.text}" created successfully${_selectedPdfFileName != null ? ' with PDF' : ''}${_selectedVideoFileName != null ? ' with Video' : ''}',
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCourseOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.offWhite, Colors.white],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.navyBlue),
              title: const Text('Edit Course'),
              onTap: () {
                Navigator.pop(context);
                _showEditCourseDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add, color: AppColors.navyBlue),
              title: const Text('Add Note'),
              onTap: () {
                Navigator.pop(context);
                _showAddNoteDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Course',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Course Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Course Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your save logic here
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Note',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your save note logic here
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Course'),
        content: const Text('Are you sure you want to delete this course?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your delete logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.newbeige,
                  AppColors.offWhite.withOpacity(0.8),
                  AppColors.offWhite,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.navyBlue,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              color: AppColors.darkGray,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Dr. Sarah",
                            style: TextStyle(
                              color: AppColors.navyBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: _toggleNotifications,
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: _notifications.any((n) => !n['read'])
                                  ? AppColors.navyBlue
                                  : AppColors.darkGray,
                              size: 28,
                            ),
                          ),
                          if (_notifications.any((n) => !n['read']))
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  '!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Cards
                        Row(
                          children: [
                            _buildStatCard(
                              "Active Courses",
                              "12",
                              Icons.book,
                              AppColors.beige,
                            ),
                            const SizedBox(width: 16),
                            _buildStatCard(
                              "Total Students",
                              "256",
                              Icons.people,
                              AppColors.lightBlue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Recent Activity Section
                        const Text(
                          "Recent Activity",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGray,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildActivityCard(
                          "New Course Enrollment",
                          "3 students enrolled in 'Flutter Development'",
                          "2h ago",
                          Icons.person_add,
                          AppColors.beige,
                        ),
                        const SizedBox(height: 12),
                        _buildActivityCard(
                          "Assignment Submitted",
                          "15 submissions for 'UI Design Basics'",
                          "5h ago",
                          Icons.assignment_turned_in,
                          AppColors.lightBlue,
                        ),
                        const SizedBox(height: 24),
                        // Quick Actions
                        const Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGray,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Modified New Course button to open file upload dialog
                            GestureDetector(
                              onTap: () => _showNewCourseDialog(context),
                              child: _buildQuickActionButton(
                                "New Course",
                                Icons.add_circle_outline,
                                AppColors.navyBlue,
                              ),
                            ),
                            _buildQuickActionButton(
                              "Assignments",
                              Icons.assignment_outlined,
                              AppColors.beige,
                            ),
                            _buildQuickActionButton(
                              "Messages",
                              Icons.message_outlined,
                              AppColors.lightBlue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Upcoming Classes
                        const Text(
                          "Upcoming Classes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGray,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onLongPress: () => _showCourseOptions(context),
                          child: _buildClassCard(
                            "Flutter Development",
                            "Today, 2:00 PM",
                            "24 students",
                            AppColors.beige,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildClassCard(
                          "UI Design Basics",
                          "Tomorrow, 10:00 AM",
                          "18 students",
                          AppColors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Notifications Panel
          if (_showNotifications)
            Positioned(
              top: 80,
              right: 16,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                for (var notification in _notifications) {
                                  notification['read'] = true;
                                }
                              });
                            },
                            child: const Text('Mark all as read'),
                          ),
                        ],
                      ),
                    ),
                    ..._notifications
                        .map((notification) => ListTile(
                              title: Text(
                                notification['title'],
                                style: TextStyle(
                                  fontWeight: notification['read']
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notification['message']),
                                  Text(
                                    notification['time'],
                                    style: TextStyle(
                                      color:
                                          AppColors.darkGray.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: notification['read']
                                  ? null
                                  : IconButton(
                                      icon: const Icon(Icons.check),
                                      onPressed: () => _markAsRead(
                                        _notifications.indexOf(notification),
                                      ),
                                    ),
                            ))
                        .toList(),
                  ],
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
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0: // Home
                // Already on home screen, just update the index
                break;
              case 1: // Courses
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructorScreen()),
                );
                break;
              case 2: // Students
                // TODO: Implement students screen navigation
                // Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsScreen()));
                break;
              case 3: // Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructorProfile()),
                );
                break;
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.navyBlue,
          unselectedItemColor: AppColors.darkGray.withOpacity(0.6),
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
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: color.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGray.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(
    String title,
    String time,
    String students,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGray.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  students,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray.withOpacity(0.5),
                  ),
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
    );
  }
}
