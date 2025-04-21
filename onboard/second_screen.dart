import 'package:flutter/material.dart';
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/onboard/2.png"),
        const SizedBox(height: 20,),
        const Text(
          "POMODORO TIMER ",
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
            "Short bursts of learning followed by breaks help consolidate information and improve long-term retention.",
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
