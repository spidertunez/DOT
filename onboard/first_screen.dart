import 'package:flutter/material.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 225,
            child: Image.asset('assets/onboard/1.png')),
        const SizedBox(height: 20,),
        const Text(
          "DOT APPLICATION ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'AbrilFatface',
              fontSize: 30,
              color: Color(0xFF213555),
              fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
          child: Text(
            "E-Learning Platform designed specifically for your needs.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'AbrilFatface',
                fontSize: 25,
              color: Color.fromARGB(255, 255, 199, 59),
                 fontWeight: FontWeight.w400
                ),
          ),
        )
      ],
    );
  }
}

