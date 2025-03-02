import 'package:flutter/material.dart';
import 'package:mockcrack/app/widgets/job_card_widget.dart';

import '../widgets/app_instruction_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JobCardItem> jobList = [
    JobCardItem(
      icon:
          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
      jobRole: 'Senior Software Engineer',
      companyName: 'Google',
      salary: '100k',
      location: 'USA',
    ),
    JobCardItem(
      icon: 'https://pngimg.com/uploads/netflix/netflix_PNG15.png',
      jobRole: 'Senior Software Engineer',
      companyName: 'Netflix',
      salary: '150k',
      location: 'Calofonia',
    ),
    JobCardItem(
      icon:
          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
      jobRole: 'Software Engineer Intern',
      companyName: 'Google',
      salary: '75k',
      location: 'USA',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfff4f3f1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-photo/3d-close-up-portrait-smiling-man_175690-201.jpg?w=740',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jhon Doe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Software Engineer',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff777765),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.star, color: Colors.white),
                      Text(
                        'Pro',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // Generate Interview

            Container(
              height: mq.height * 0.45,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prep from Real Job Postings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  // intructions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appInstructionCard(
                        icon: Icon(Icons.phone_android,
                            color: Colors.blue, size: 30),
                        description: 'Browse Jobs from Various Job Postings',
                      ),
                      Column(
                        children: [
                          SizedBox(height: 40),
                          Container(
                            height: 2,
                            width: 50,
                            child: CustomPaint(
                              painter: DottedLinePainter(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      appInstructionCard(
                        icon: Icon(Icons.share, color: Colors.blue, size: 30),
                        description:
                            'Share the Job Description and write it down there',
                      ),
                      Column(
                        children: [
                          SizedBox(height: 40),
                          Container(
                            height: 2,
                            width: 50,
                            child: CustomPaint(
                              painter: DottedLinePainter(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      appInstructionCard(
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/3324/3324855.png',
                          height: 30,
                          width: 30,
                          color: Colors.blue,
                        ),
                        description: "We'll Generate a Mock Interview",
                      ),
                    ],
                  ),

                  // generate button
                  Column(
                    children: [
                      // text field
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    child: CustomPaint(
                      painter: DottedLinePainter(color: Colors.grey),
                    ),
                  ),

                  // generate button
                  Column(
                    children: [
                      // text field
                      Container(
                        height: mq.height * 0.07,
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffc2c2c2),
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ],
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Paste Job Description',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      // button
                      Container(
                        height: mq.height * 0.07,
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xff062f29),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3324/3324855.png',
                                height: 25,
                                width: 25,
                                color: Color(0xffb1d580)),
                            SizedBox(width: 10),
                            Text(
                              'Generate Interview',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffb1d580)),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            // Frictious Job Posts

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Frictious Job Posts for Prep',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jobList.length,
                    itemBuilder: (context, index) {
                      return jobCard(context, jobList[index]);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
