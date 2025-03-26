import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../services/api_service.dart';
import '../../utils/colors.dart';
import 'interview_screen.dart';

class GeneratingInterviewJobpost extends StatefulWidget {
  final String jobDescription;
  const GeneratingInterviewJobpost({super.key, required this.jobDescription});

  @override
  State<GeneratingInterviewJobpost> createState() =>
      _GeneratingInterviewJobpostState();
}

class _GeneratingInterviewJobpostState
    extends State<GeneratingInterviewJobpost> {
  double progress = 0.0;
  bool isGenerating = true;
  List<String> questions = [];

  @override
  void initState() {
    super.initState();
    generateQuestions();
  }

  int generatedCount = 0;
  void generateQuestions() async {
    final response = await ApiService().generateInterviewWithRealJob(
      jobdescription: widget.jobDescription,
    );

    for (var question in response) {
      setState(() {
        questions.add(question);
        generatedCount += 1;
      });
      await Future.delayed(Duration(milliseconds: 500));
    }

    setState(() {
      isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Generating Questions')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20),
            Lottie.asset('assets/animations/loading.json'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: LinearProgressIndicator(
                    value: isGenerating ? null : 1.0,
                    color: AppColor.secondary,
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                    isGenerating
                        ? 'Generating questions : $generatedCount'
                        : 'Questions generated!',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterviewScreen(
                      questions: questions,
                    ),
                  ),
                );
              },
              child: Container(
                height: mq.height * 0.05,
                width: mq.width * 0.5,
                decoration: BoxDecoration(
                  color: isGenerating ? Colors.white : AppColor.secondary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Start Interview",
                    style: TextStyle(
                      color: !isGenerating ? Colors.white : AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
