import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hom/theme/Appcolors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = '';
  String email = '';
  int totalCourses = 0;
  int totalHours = 0;
  int streakDays = 0;
  List<Map<String, dynamic>> currentCourses = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) return;

    final url = Uri.parse('https://eba7-197-35-224-52.ngrok-free.app/api/profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        fullName = data['fullName'];
        email = data['email'];
        totalCourses = data['totalCourses'];
        totalHours = data['totalHours'];
        streakDays = data['streakDays'];
        currentCourses = List<Map<String, dynamic>>.from(data['currentCourses']);
        isLoading = false;
      });
    } else {
      print('Error: ${response.statusCode}');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            _buildStats(),
            const SizedBox(height: 25),
            _buildCurrentLearning(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.navyBlue,
          child: Text(
            fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
            style: const TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          fullName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statCard("Courses", totalCourses.toString(), Icons.book),
        _statCard("Hours", totalHours.toString(), Icons.timer),
        _statCard("Streak", streakDays.toString(), Icons.local_fire_department),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.navyBlue, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCurrentLearning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Currently Learning",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ...currentCourses.map((course) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _courseProgressItem(
            course['title'],
            course['progress'],
            _getIconFromName(course['icon']),
          ),
        )),
      ],
    );
  }

  Widget _courseProgressItem(String title, double progress, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.navyBlue, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: progress,
                color: AppColors.navyBlue,
                backgroundColor: AppColors.navyBlue.withOpacity(0.2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text("${(progress * 100).toInt()}%"),
      ],
    );
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'phone_android':
        return Icons.phone_android;
      case 'design_services':
        return Icons.design_services;
      case 'code':
        return Icons.code;
      default:
        return Icons.school;
    }
  }
}