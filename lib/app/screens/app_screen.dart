import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mockcrack/app/screens/home_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<Widget> screens = [
    const HomeScreen(),
  ];

  int currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIdx],
      bottomNavigationBar: Container(
        color: const Color(0xff062f29),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: GNav(
          backgroundColor: const Color(0xff062f29),
          color: Colors.white,
          activeColor: const Color(0xffb1d580),
          tabBackgroundColor: Colors.green.shade800,
          gap: 8,
          padding: const EdgeInsets.all(12),
          onTabChange: (index) {
            // ignore: avoid_print
            print(index);
          },
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.add_to_photos_rounded, text: 'Create'),
            GButton(icon: Icons.bookmark, text: 'Preps'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
