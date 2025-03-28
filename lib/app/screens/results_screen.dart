import 'package:flutter/material.dart';
import 'package:mockcrack/app/screens/app_screen.dart';
import 'package:mockcrack/app/screens/interview_screen.dart';

import '../../services/api_service.dart';
import '../../utils/colors.dart';

class ResultsScreen extends StatefulWidget {
  final List<String> questions;

  final List<Answer> answers;
  const ResultsScreen(
      {super.key, required this.questions, required this.answers});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int selectedIndex = 0;

  int getAvgScore(List<int> scores) {
    if (scores.isEmpty) return 0;
    int sum = 0;
    for (final score in scores) {
      sum += score;
    }
    return sum ~/ scores.length;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: const Text('Interview Results',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: AppColor.background,
          actions: [
            CircleAvatar(
              radius: 35,
              backgroundColor: AppColor.secondaryLight,
              child: Center(
                child: Text(
                  getAvgScore(widget.answers.map((e) => e.score).toList())
                      .toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: mq.height * 0.07,
                ),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffc2c2c2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Questions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.questions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                backgroundColor: index != selectedIndex
                                    ? AppColor.surface
                                    : AppColor.secondaryLight,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: AppColor.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: mq.height * 0.04),
                    Container(
                      height: mq.height * 0.15,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffc2c2c2),
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: mq.height * 0.15,
                            width: mq.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: AppColor.secondaryLight,
                            ),
                            child: Center(
                              child: Text(
                                "Q${selectedIndex + 1}",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.questions[selectedIndex],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Text(
                            "Answer",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CircleAvatar(
                              backgroundColor: AppColor.secondaryLight,
                              child: Text(
                                widget.answers[selectedIndex].score.toString(),
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.answers[selectedIndex].answer,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Accuracy of Your Answer",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.answers[selectedIndex].accuracy,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => InterviewScreen(
                              questions: [],
                            )));
                  },
                  child: Container(
                    height: mq.height * 0.07,
                    width: double.infinity,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff062f29),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            'https://cdn-icons-png.flaticon.com/512/3324/3324855.png',
                            height: 25,
                            width: 25,
                            color: const Color(0xffb1d580)),
                        const SizedBox(width: 10),
                        const Text(
                          'Retake Interview',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffb1d580)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) => AppScreen()));
                  },
                  child: Text('Back to Home'))
            ],
          ),
        ));
  }
}
