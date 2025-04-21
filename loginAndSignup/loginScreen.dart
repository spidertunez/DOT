import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home.dart';
import 'package:hom/loginAndSignup/signupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('https://eba7-197-35-224-52.ngrok-free.app/api/auth/login');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          "userType": 2,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final String? token = responseData['token'];
        final String? userId = responseData['userId'];
        final String? userType = responseData['userType'];

        if (token != null) {
          print("Access Token: $token");

          // تخزين البيانات في SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
          if (userId != null) await prefs.setString('user_id', userId);
          if (userType != null) await prefs.setString('user_type', userType);

          // الانتقال إلى الشاشة الرئيسية
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          setState(() {
            _errorMessage = "Token not found in response.";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Invalid credentials. Try again.";
        });
      }
    } catch (error) {
      print("Error occurred: $error");
      setState(() {
        _errorMessage = "Something went wrong. Please try again later.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome Back!",
                    style: TextStyle(
                        fontFamily: 'AbrilFatface',
                        fontSize: 35,
                        color: Color(0xFF213555),
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                SizedBox(
                  height: 270,
                  child: Image.asset("assets/loginAndSignup/login.png"),
                ),
                const SizedBox(height: 30),
                _buildTextField(_emailController, "Email", Icons.email),
                const SizedBox(height: 10),
                _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                const SizedBox(height: 10),

                if (_errorMessage != null)
                  Text(_errorMessage!,
                      style: const TextStyle(color: Colors.red)),

                const SizedBox(height: 20),
                _buildLoginButton(),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "I don't have an account? Signup",
                    style: TextStyle(
                      color: Color(0xFF213555),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      IconData icon, {
        bool isPassword = false,
      }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF213555),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
