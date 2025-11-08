// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LMS - Learning Management System';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get emailOrPhone => 'Email or Phone';

  @override
  String get emailOrPhoneHint => 'Enter your email or phone number';

  @override
  String get emailOrPhoneError => 'Please enter your email or phone number';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordError => 'Please enter your password';

  @override
  String get passwordMinLengthError => 'Password must be at least 6 characters';

  @override
  String get student => 'Student';

  @override
  String get parent => 'Parent';

  @override
  String get teacher => 'Teacher';

  @override
  String get welcomeMessage => 'Welcome to our educational platform';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get selectEducationSystem => 'Select Education System';

  @override
  String get selectEducationalStage => 'Select Educational Stage';

  @override
  String get selectClassroomGrade => 'Select Classroom/Grade';

  @override
  String get selectAcademicTerm => 'Select Academic Term';

  @override
  String get selectEducationalTrack => 'Select Educational Track';

  @override
  String get back => 'Back';

  @override
  String get continueToSubjects => 'Continue to Subjects';

  @override
  String get subjects => 'Subjects';

  @override
  String subjectsFound(int count) {
    return '$count subjects found';
  }

  @override
  String get viewAllDetails => 'View All Details';

  @override
  String get searchSubjects => 'Search subjects...';

  @override
  String get noSubjectsAvailable => 'No subjects available';

  @override
  String noSubjectsFound(String query) {
    return 'No subjects found for \"$query\"';
  }

  @override
  String get clearSearch => 'Clear Search';

  @override
  String get lessons => 'Lessons';

  @override
  String get searchLessons => 'Search lessons...';

  @override
  String get noLessonsAvailable => 'No lessons available';

  @override
  String noLessonsFound(String query) {
    return 'No lessons found for \"$query\"';
  }

  @override
  String get completedOnly => 'Completed Only';

  @override
  String completed(int completed, int total) {
    return '$completed/$total completed';
  }

  @override
  String get quizStatistics => 'Quiz Statistics';

  @override
  String get totalQuestions => 'Total Questions';

  @override
  String get correctAnswers => 'Correct Answers';

  @override
  String get wrongAnswers => 'Wrong Answers';

  @override
  String get totalTime => 'Total Time';

  @override
  String get backToLessons => 'Back to Lessons';

  @override
  String get excellent => 'Excellent!';

  @override
  String get goodJob => 'Good Job!';

  @override
  String get keepPracticing => 'Keep Practicing!';

  @override
  String get logoutConfirmation => 'Logout';

  @override
  String get logoutConfirmationMessage => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get refresh => 'Refresh';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get settings => 'Settings';

  @override
  String get educationalSelection => 'Educational Selection';

  @override
  String get unknownStep => 'Unknown step';

  @override
  String get general => 'General';
}
