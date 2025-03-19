import 'package:flutter/material.dart';
import 'package:mockcrack/utils/colors.dart';

import '../../domain/entities/users_entity.dart';

class UserProfileScreen extends StatefulWidget {
  final UserEntity user;
  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Mock user data
  final Map<String, dynamic> userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'role': 'Full Stack Developer',
    'experience': '5 years',
    'interviews_taken': 15,
    'avg_score': 82,
    'skills': [
      'React',
      'Node.js',
      'Python',
      'Flutter',
      'MongoDB',
      'AWS',
      'Docker',
      'TypeScript',
    ],
    'preferred_roles': [
      'Full Stack Developer',
      'Frontend Developer',
      'Mobile Developer',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    final user = widget.user;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF062F29),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xffb1d580),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          user.username!.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF062F29),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name
                    Text(
                      user.username!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Role
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffb1d580).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.occupation!,
                        style: const TextStyle(
                          color: Color(0xffb1d580),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Stats Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _buildStatCard(
                      'Interviews',
                      user.interviews!.length.toString(),
                      Icons.assignment,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      'Avg Score',
                      user.score.toString(),
                      Icons.analytics,
                    ),
                  ],
                ),
              ),

              // Skills Section

              _buildSection(
                'Skills',
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (user.techStack!).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF062F29).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: Color(0xFF062F29),
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              if (user.techStack!.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF062F29),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Add Skills",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Preferred Roles Section
              _buildSection(
                'Preferred Roles',
                Column(
                  children: (user.preferences!)
                      .map((role) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.work_outline,
                                  color: Color(0xFF062F29),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  role,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF062F29),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),

              if (user.techStack!.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF062F29),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Add Preferences",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Edit Profile Button
              Container(
                width: double.infinity,
                height: mq.height * 0.07,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff062f29),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Color(0xffb1d580),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffb1d580),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFF062F29),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF062F29),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF062F29),
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}
