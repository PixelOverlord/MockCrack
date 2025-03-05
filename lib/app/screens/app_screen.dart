import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mockcrack/app/screens/home_screen.dart';
import 'package:mockcrack/app/screens/custom_interview_screen.dart';
import 'package:mockcrack/app/screens/interview_history_screen.dart';
import 'package:mockcrack/app/screens/user_profile_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CustomInterviewScreen(),
    const InterviewHistoryScreen(),
    const UserProfileScreen(),
  ];

  int currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIdx],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[400]!,
            activeColor: const Color(0xff062f29),
            tabBackgroundColor: const Color(0xff062f29).withOpacity(0.1),
            gap: 8,
            padding: const EdgeInsets.all(16),
            onTabChange: (index) {
              setState(() {
                currentIdx = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.add_circle_outline, text: 'Custom'),
              GButton(icon: Icons.history, text: 'History'),
              GButton(icon: Icons.person_outline, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
