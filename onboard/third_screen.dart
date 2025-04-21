import 'package:flutter/material.dart';
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/onboard/3.png"),
        const SizedBox(height: 20,),
        const Text(
          "MAINTAIN YOUR STRAEK ",
          textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'AbrilFatface',
                fontSize: 30,
                color: Color(0xFF213555),
                fontWeight: FontWeight.bold)

        ),
        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Meet your weekly target or maintain a learning streak when you practice in the app",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'AbrilFatface',
                fontSize: 25,
                color: Color.fromARGB(255, 255, 199, 59),
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ],
    );
  }
}
