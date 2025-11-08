class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://taseese.org';
  static const String loginEndpoint = '/api/login';
  static const String educationSystemsEndpoint = '/api/public/systems';
  static const String educationStagesEndpoint = '/api/public/stages';
  static const String classroomsEndpoint = '/api/public/classrooms';
  static const String termsEndpoint = '/api/public/terms';
  static const String pathsEndpoint = '/api/public/paths';
  static const String subjectsEndpoint = '/api/public/subjects';
  static const String lessonsEndpoint = '/api/lessons';
  static const String questionsEndpoint = '/api/lessons/questions';
  static const String answerEndpoint = '/api/add/lesson/question/answer';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String selectedSystemKey = 'selected_system';
  static const String selectedStageKey = 'selected_stage';
  static const String selectedClassroomKey = 'selected_classroom';
  static const String selectedTermKey = 'selected_term';
  static const String selectedPathKey = 'selected_path';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Quiz Constants
  static const int maxAttempts = 3;
  static const int defaultQuestionTime = 30; // seconds
}
