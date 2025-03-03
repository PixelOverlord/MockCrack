import 'package:flutter/material.dart';
import 'package:mockcrack/app/screens/interview_screen.dart';
import 'package:mockcrack/app/widgets/job_card_widget.dart';

class InterviewDescription extends StatefulWidget {
  final JobCardItem item;
  const InterviewDescription({super.key, required this.item});

  @override
  State<InterviewDescription> createState() => _InterviewDescriptionState();
}

class _InterviewDescriptionState extends State<InterviewDescription> {
  bool showDescription = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff4f3f1),
      appBar: AppBar(
        backgroundColor: const Color(0xfff4f3f1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Card
          Center(child: jobCard(context, widget.item)),
          const SizedBox(height: 30),

          // Scrollable Content
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Toggle
                  Center(
                    child: Container(
                      height: mq.height * 0.07,
                      width: mq.width * 0.7,
                      decoration: BoxDecoration(
                        color: const Color(0xfff4f3f1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => showDescription = true),
                              child: Container(
                                height: double.infinity,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: showDescription
                                      ? Colors.white
                                      : const Color(0xfff4f3f1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => showDescription = false),
                              child: Container(
                                height: double.infinity,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: !showDescription
                                      ? Colors.white
                                      : const Color(0xfff4f3f1),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Scores",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDescription) ...[
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "We are looking for a Senior Software Developer to join our dynamic team. You will be responsible for designing, developing, and maintaining high-performance applications. As a senior member, you will provide technical leadership, mentor junior developers, and collaborate with cross-functional teams to deliver scalable solutions.",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Responsibilities',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "• Design, develop, test, and maintain high-quality software applications.\n"
                              "• Write clean, efficient, and well-documented code following industry best practices.\n"
                              "• Architect scalable and maintainable systems, ensuring high performance and security.\n"
                              "• Collaborate with cross-functional teams, including product managers, designers, and DevOps.\n"
                              "• Conduct code reviews, provide technical guidance, and mentor junior developers.\n"
                              "• Optimize application performance and troubleshoot production issues.\n"
                              "• Stay up to date with emerging technologies and industry trends to drive innovation.\n"
                              "• Participate in Agile development processes, including sprint planning, stand-ups, and retrospectives.",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18),
                            ),
                          ],
                          if (!showDescription) ...[
                            SizedBox(height: mq.height * 0.1),
                            Center(
                              child: const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                            SizedBox(height: mq.height * 0.03),
                            const Text(
                              "No Previous Interview Found",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => InterviewScreen()));
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
                            'Generate Interview',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffb1d580)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
