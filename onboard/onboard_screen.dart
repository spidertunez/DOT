import 'package:flutter/material.dart';
import 'package:hom/onboard/second_screen.dart';
import 'package:hom/onboard/third_screen.dart';

import '../loginAndSignup/loginScreen.dart';
import '../loginAndSignup/signupScreen.dart';
import 'first_screen.dart';


class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              controller: _controller,
              children: const [FirstScreen(), SecondScreen(), ThirdScreen()],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIndicator(active: index == 0),
              const SizedBox(width: 5),
              CustomIndicator(active: index == 1),
              const SizedBox(width: 5),
              CustomIndicator(active: index == 2),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (index == 2) {
                      // Navigate to RegisterScreen when "Register" is clicked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    index == 2 ? "Register" : "Skip",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF213555),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (index == 2) {
                      // Navigate to LoginScreen when "Login" is clicked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } else {
                      _controller.animateToPage(
                        index + 1,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linear,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF213555),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      index == 2 ? "Login" : "Next",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? const Color(0xFF213555) : Colors.grey, // Updated color
      ),
      width: active ? 30 : 10,
      height: 10,
    );
  }
}
