import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class QuestionModel {
  final String question;
  final List<String> options;

  QuestionModel({required this.question, required this.options});
}

class SurveyState with ChangeNotifier {
  int currentQuestionIndex = 0;
  List<String?> userAnswers = List.filled(10, null);
  final PageController pageController = PageController();

  final List<QuestionModel> questions = [
    QuestionModel(
      question: "Do you do most of your shopping in?",
      options: ["In stores", "Online", "Both", "Rarely"],
    ),
    QuestionModel(
      question: "How often do you shop online?",
      options: [
        "3+ times / week",
        "1-2 times / week",
        "1+ times / month",
        "7-12 times / year",
      ],
    ),
    QuestionModel(
      question: "Do you prefer cash or card payments?",
      options: ["Cash", "Card", "Both", "Depends"],
    ),
    QuestionModel(
      question: "How important are discounts to you?",
      options: [
        "Very important",
        "Somewhat important",
        "Neutral",
        "Not important",
      ],
    ),
  ];

  void nextQuestion(String selectedOption) {
    userAnswers[currentQuestionIndex] = selectedOption;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      print("Survey Completed: $userAnswers");
    }
  }
}

class SurveyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SurveyState(),
      child: Scaffold(
        backgroundColor: Color(0xFFF6F0F0),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SurveyState>(
                  builder: (context, surveyState, child) {
                    int totalQuestions = surveyState.questions.length;
                    int currentIndex = surveyState.currentQuestionIndex;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalQuestions, (index) {
                        return Container(
                          width: 33,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color:
                            index <= currentIndex
                                ? Color(0xFFA5A9DD)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    );
                  },
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      child: Text(
                        "Let's find the best track for you:",
                        style: TextStyle(
                          fontFamily: 'AbrilFatface',
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -90,
                      top: -8,
                      child: Image.asset(
                        "assets/3dicons.png",
                        width: 290,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<SurveyState>(
                    builder: (context, surveyState, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.58,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffC1C5F3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            FadeInUp(
                              duration: Duration(milliseconds: 500),
                              child: Text(
                                "Question ${surveyState.currentQuestionIndex + 1} of ${surveyState.questions.length}",
                                style: TextStyle(
                                  fontFamily: 'AbrilFatface',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF213555),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: PageView.builder(
                                controller: surveyState.pageController,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: surveyState.questions.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FadeInUp(
                                        duration: Duration(milliseconds: 600),
                                        child: Text(
                                          surveyState.questions[index].question,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'AbrilFatface',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF213555),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
