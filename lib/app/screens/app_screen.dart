import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mockcrack/app/cubits/user/user_cubit.dart';
import 'package:mockcrack/app/screens/home_screen.dart';
import 'package:mockcrack/app/screens/custom_interview_screen.dart';
import 'package:mockcrack/app/screens/interview_history_screen.dart';
import 'package:mockcrack/app/screens/user_profile_screen.dart';

class AppScreen extends StatefulWidget {
  final String uid;
  const AppScreen({super.key, required this.uid});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<Widget> screens = [];

  int currentIdx = 0;

  @override
  void initState() {
    super.initState();
    if (widget.uid.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).getUser(uid: widget.uid);
    } else {
      debugPrint("Error: widget.uid is null or empty!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserError) {
          return Text(state.message);
        }
        if (state is UserLoaded) {
          final user = state.user;

          screens = [
            HomeScreen(user: user),
            CustomInterviewScreen(),
            InterviewHistoryScreen(),
            UserProfileScreen(user: user),
          ];

          return Scaffold(
            body: screens[currentIdx],
            bottomNavigationBar: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
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
        return SizedBox();
      },
    );
  }
}
