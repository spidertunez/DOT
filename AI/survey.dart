import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EduRecommendationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Field Recommendation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: RecommendationSurvey(),
    );
  }
}

class RecommendationSurvey extends StatefulWidget {
  @override
  _RecommendationSurveyState createState() => _RecommendationSurveyState();
}

class _RecommendationSurveyState extends State<RecommendationSurvey> {
  final List<String> questions = [
    "How interested are you in data analysis?",
    "How comfortable are you dealing with clients?",
    "Do you prefer working on web user interface development?",
    "Do you prefer working on backend and databases?",
    "How strong is your math and statistics background?",
    "How interested are you in visual design and UI interactivity?",
    "Do you enjoy optimizing server-side performance?",
    "Do you enjoy solving complex problems?",
    "How interested are you in machine learning and AI?",
    "How proficient are you in programming languages?",
    "Do you enjoy designing responsive interfaces?",
    "How familiar are you with handling large databases?",
    "Do you prefer working on algorithms and efficiency?",
    "Are you interested in game development?",
    "Do you have experience in optimizing client-side performance?",
    "Do you enjoy using app-building tools like React?",
    "How familiar are you with building REST APIs?",
    "Do you enjoy working on application security?",
    "Do you prefer dynamic, short-term projects?",
    "Do you enjoy continuously learning new technologies?",
  ];

  final List<String> options = [
    "Not at all",
    "Slightly",
    "Somewhat",
    "Very",
    "Extremely"
  ];

  List<String?> answers = List.filled(20, null);
  int currentQuestion = 0;
  bool isLoading = false;
  String? recommendation;

  Future<void> submitAnswers() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://9601-197-35-232-169.ngrok-free.app/api/Recommendation/predict'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"answers": answers}),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => recommendation = data['recommendation']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Prediction failed. Try again later.')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
    }
  }

  void nextQuestion(String? answer) {
    answers[currentQuestion] = answer;

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        submitAnswers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 24),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(1, 0),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey(currentQuestion),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${currentQuestion + 1} of ${questions.length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      questions[currentQuestion],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24),
                    ...options.map((option) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: answers[currentQuestion] == option
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[200],
                          foregroundColor: answers[currentQuestion] == option
                              ? Colors.white
                              : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => nextQuestion(option),
                        child: Text(option, style: TextStyle(fontSize: 16)),
                      ),
                    )),
                  ],
                ),
              ),
              if (recommendation != null) ...[
                SizedBox(height: 40),
                Text("🎯 Recommended Field:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(recommendation!, style: TextStyle(fontSize: 20)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
