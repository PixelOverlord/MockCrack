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
}
