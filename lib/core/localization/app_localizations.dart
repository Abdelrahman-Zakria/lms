import 'package:flutter/material.dart';
import 'package:lms/l10n/app_localizations.dart' as gen;

/// Wrapper class for app localizations
class AppLocalizations {
  final gen.AppLocalizations _delegate;

  AppLocalizations(this._delegate);

  static AppLocalizations? of(BuildContext context) {
    final delegate = gen.AppLocalizations.of(context);
    return delegate != null ? AppLocalizations(delegate) : null;
  }

  static const LocalizationsDelegate<gen.AppLocalizations> delegate =
      gen.AppLocalizations.delegate;

  // App title
  String get appTitle => _delegate.appTitle;

  // Common
  String get welcome => _delegate.welcome;
  String get login => _delegate.login;
  String get logout => _delegate.logout;
  String get cancel => _delegate.cancel;
  String get refresh => _delegate.refresh;
  String get back => _delegate.back;

  // Login
  String get emailOrPhone => _delegate.emailOrPhone;
  String get emailOrPhoneHint => _delegate.emailOrPhoneHint;
  String get emailOrPhoneError => _delegate.emailOrPhoneError;
  String get password => _delegate.password;
  String get passwordHint => _delegate.passwordHint;
  String get passwordError => _delegate.passwordError;
  String get passwordMinLengthError => _delegate.passwordMinLengthError;
  String get student => _delegate.student;
  String get parent => _delegate.parent;
  String get teacher => _delegate.teacher;
  String get welcomeMessage => _delegate.welcomeMessage;
  String get loginFailed => _delegate.loginFailed;

  // Home
  String get selectEducationSystem => _delegate.selectEducationSystem;
  String get selectEducationalStage => _delegate.selectEducationalStage;
  String get selectClassroomGrade => _delegate.selectClassroomGrade;
  String get selectAcademicTerm => _delegate.selectAcademicTerm;
  String get selectEducationalTrack => _delegate.selectEducationalTrack;
  String get continueToSubjects => _delegate.continueToSubjects;
  String get educationalSelection => _delegate.educationalSelection;
  String get unknownStep => _delegate.unknownStep;

  // Subjects
  String get subjects => _delegate.subjects;
  String subjectsFound(int count) => _delegate.subjectsFound(count);
  String get viewAllDetails => _delegate.viewAllDetails;
  String get searchSubjects => _delegate.searchSubjects;
  String get noSubjectsAvailable => _delegate.noSubjectsAvailable;
  String noSubjectsFound(String query) => _delegate.noSubjectsFound(query);
  String get clearSearch => _delegate.clearSearch;

  // Lessons
  String get lessons => _delegate.lessons;
  String get searchLessons => _delegate.searchLessons;
  String get noLessonsAvailable => _delegate.noLessonsAvailable;
  String noLessonsFound(String query) => _delegate.noLessonsFound(query);
  String get completedOnly => _delegate.completedOnly;
  String completed(int completed, int total) => _delegate.completed(completed, total);
  String get general => _delegate.general;

  // Quiz
  String get quizStatistics => _delegate.quizStatistics;
  String get totalQuestions => _delegate.totalQuestions;
  String get correctAnswers => _delegate.correctAnswers;
  String get wrongAnswers => _delegate.wrongAnswers;
  String get totalTime => _delegate.totalTime;
  String get backToLessons => _delegate.backToLessons;
  String get excellent => _delegate.excellent;
  String get goodJob => _delegate.goodJob;
  String get keepPracticing => _delegate.keepPracticing;

  // Settings
  String get logoutConfirmation => _delegate.logoutConfirmation;
  String get logoutConfirmationMessage => _delegate.logoutConfirmationMessage;
  String get language => _delegate.language;
  String get theme => _delegate.theme;
  String get lightTheme => _delegate.lightTheme;
  String get darkTheme => _delegate.darkTheme;
  String get english => _delegate.english;
  String get arabic => _delegate.arabic;
  String get settings => _delegate.settings;
}

