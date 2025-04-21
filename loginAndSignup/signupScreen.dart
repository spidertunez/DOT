import 'dart:convert';
import 'package:hom/loginAndSignup/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../home/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _nameController = TextEditingController();
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
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('https://5087-197-35-242-200.ngrok-free.app/api/auth/register');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'username': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201 && responseData['success'] == true) {
        final accessToken = responseData['data']['token'];
        print("Access token: $accessToken");

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = responseData['errors'] != null && responseData['errors'].isNotEmpty
              ? responseData['errors'].join("\n")
              : responseData['message'] ?? "Registration failed. Try again.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Something went wrong. Please try again later.";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(
                      fontFamily: 'AbrilFatface',
                      fontSize: 35,
                      color: Color(0xFF213555),
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),

                // Logo at the top
                SizedBox(
                  height: 250, // Adjust logo size
                  child: Image.asset("assets/loginAndSignup/signup.png"), // Change image for register
                ),
                const SizedBox(height: 30),

                _buildTextField(_nameController, "Full Name", Icons.person),
                const SizedBox(height: 10),
                _buildTextField(_emailController, "Email", Icons.email),
                const SizedBox(height: 10),
                _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                const SizedBox(height: 10),

                // Error message (if any)
                if (_errorMessage != null)
                  Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

                const SizedBox(height: 20),

                // Register Button
                _buildRegisterButton(),

                const SizedBox(height: 20),

                // Navigate to Login
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Color(0xFF213555), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isPassword = false}) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity, // Full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF213555),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: _isLoading ? null : _register,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          "Register",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
