import 'package:flutter/material.dart';
import 'package:mockcrack/app/screens/generating_interview_screen.dart';
import 'package:mockcrack/app/screens/interview_screen.dart';
import 'package:mockcrack/services/api_service.dart';
import 'package:mockcrack/utils/colors.dart';

class CustomInterviewScreen extends StatefulWidget {
  const CustomInterviewScreen({super.key});

  @override
  State<CustomInterviewScreen> createState() => _CustomInterviewScreenState();
}

class _CustomInterviewScreenState extends State<CustomInterviewScreen> {
  final List<String> jobRoles = [
    // Software Roles
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'Mobile Developer',
    'DevOps Engineer',
    'Software Engineer',
    'Machine Learning Engineer',
    'AI Engineer',
    'Data Scientist',
    'Data Engineer',
    'Cloud Engineer',
    'Cybersecurity Engineer',
    'Game Developer',
    'Embedded Software Engineer',
    'AR/VR Developer',
    'Blockchain Developer',
    'Site Reliability Engineer',
    'UI/UX Designer',
    'QA Engineer',
    'Automation Engineer',
    'Database Administrator',
    'Solutions Architect',
    'Technical Product Manager',
    'System Analyst',
    'Technical Support Engineer',

    // Hardware Roles
    'Hardware Engineer',
    'Firmware Engineer',
    'VLSI Engineer',
    'FPGA Engineer',
    'IoT Engineer',
    'Electrical Engineer',
    'Embedded Systems Engineer',
    'Robotics Engineer',
    'Chip Design Engineer',
    'RF Engineer',
    'Aerospace Engineer',
    'Automotive Engineer',
    'Mechatronics Engineer',
    'Network Engineer',
    'Telecommunications Engineer',
  ];

  final List<String> experienceLevels = [
    'Intern',
    'Junior',
    'Senior',
    'Principal',
  ];

  String? selectedRole;
  String? selectedLevel;
  final TextEditingController _techStackController = TextEditingController();
  List<String> techStacks = []; // List to store tech stack entries
  // List<String> temp = [];
  bool generating = false;
  @override
  void dispose() {
    _techStackController.dispose();
    super.dispose();
  }

  void _onGenerateInterview() async {
    if (selectedRole != null &&
        selectedLevel != null &&
        techStacks.isNotEmpty) {
      print("pressed");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GeneratingInterviewScreen(
            role: selectedRole!,
            experience: selectedLevel!,
            techStacks: techStacks,
          ),
        ),
      );
    }
  }

  void _addTechStack(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !techStacks.contains(trimmed)) {
      setState(() {
        techStacks.add(trimmed);
      });
    }
  }

  void _removeTechStack(String tech) {
    setState(() {
      techStacks.remove(tech);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Custom Interview',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Customize your interview experience',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Role Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffc2c2c2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedRole,
                    isExpanded: true,
                    hint: const Text('Select Role'),
                    items: jobRoles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Experience Level Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffc2c2c2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLevel,
                    isExpanded: true,
                    hint: const Text('Select Experience Level'),
                    items: experienceLevels.map((String level) {
                      return DropdownMenuItem<String>(
                        value: level,
                        child: Text(level),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedLevel = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tech Stack Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: techStacks.map((stack) {
                    return Chip(
                      label: Text(stack),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => _removeTechStack(stack),
                      backgroundColor: const Color(0xFF062F29),
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _techStackController,
                  decoration: InputDecoration(
                    hintText: 'Enter tech stacks (comma-separated)',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                  ),
                  onChanged: (value) {
                    if (value.contains(',')) {
                      final parts = value.split(',');
                      for (var part in parts) {
                        _addTechStack(part);
                      }
                      _techStackController.clear();
                    }
                  },
                ),
              ),

              // Generate Interview Button
              GestureDetector(
                onTap: _onGenerateInterview,
                child: Container(
                  height: mq.height * 0.07,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff062f29),
                    borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
