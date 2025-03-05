import 'package:mockcrack/app/screens/custom_interview_screen.dart';

class AppConstants {
  static const String appName = 'MockCrack';
  static const String appVersion = '1.0.0';

  // API endpoints
  static const String baseUrl = 'https://api.mockcrack.com';
  static const String generateQuestionsEndpoint = '/questions';
  static const String evaluateAnswerEndpoint = '/evaluate';

  // SharedPreferences keys
  static const String sessionHistoryKey = 'session_history';

  // Job roles
  static const List<String> availableJobRoles = [
    'Software Engineer',
    'Data Scientist',
    'Product Manager',
    'UI/UX Designer',
    'DevOps Engineer',
  ];

  // AI response for custom interview
  String customInterviewScreen(
          String role, String experience, List<String> techstacks) =>
      "Generate a custom interview for a $role hiring for a $experience level employee with the following technologies: $techstacks. Please structure the interview with each question clearly numbered, starting with '1.', '2.', '3.', and so on. Ensure that each numbered question is on a new line. Generate a mock interview separated by numbers for regex.";
}
