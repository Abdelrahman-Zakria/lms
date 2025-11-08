import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'LMS - Learning Management System'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @emailOrPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number'**
  String get emailOrPhoneHint;

  /// No description provided for @emailOrPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone number'**
  String get emailOrPhoneError;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordError;

  /// No description provided for @passwordMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLengthError;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get parent;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our educational platform'**
  String get welcomeMessage;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @selectEducationSystem.
  ///
  /// In en, this message translates to:
  /// **'Select Education System'**
  String get selectEducationSystem;

  /// No description provided for @selectEducationalStage.
  ///
  /// In en, this message translates to:
  /// **'Select Educational Stage'**
  String get selectEducationalStage;

  /// No description provided for @selectClassroomGrade.
  ///
  /// In en, this message translates to:
  /// **'Select Classroom/Grade'**
  String get selectClassroomGrade;

  /// No description provided for @selectAcademicTerm.
  ///
  /// In en, this message translates to:
  /// **'Select Academic Term'**
  String get selectAcademicTerm;

  /// No description provided for @selectEducationalTrack.
  ///
  /// In en, this message translates to:
  /// **'Select Educational Track'**
  String get selectEducationalTrack;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueToSubjects.
  ///
  /// In en, this message translates to:
  /// **'Continue to Subjects'**
  String get continueToSubjects;

  /// No description provided for @subjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// No description provided for @subjectsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} subjects found'**
  String subjectsFound(int count);

  /// No description provided for @viewAllDetails.
  ///
  /// In en, this message translates to:
  /// **'View All Details'**
  String get viewAllDetails;

  /// No description provided for @searchSubjects.
  ///
  /// In en, this message translates to:
  /// **'Search subjects...'**
  String get searchSubjects;

  /// No description provided for @noSubjectsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No subjects available'**
  String get noSubjectsAvailable;

  /// No description provided for @noSubjectsFound.
  ///
  /// In en, this message translates to:
  /// **'No subjects found for \"{query}\"'**
  String noSubjectsFound(String query);

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get clearSearch;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @searchLessons.
  ///
  /// In en, this message translates to:
  /// **'Search lessons...'**
  String get searchLessons;

  /// No description provided for @noLessonsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No lessons available'**
  String get noLessonsAvailable;

  /// No description provided for @noLessonsFound.
  ///
  /// In en, this message translates to:
  /// **'No lessons found for \"{query}\"'**
  String noLessonsFound(String query);

  /// No description provided for @completedOnly.
  ///
  /// In en, this message translates to:
  /// **'Completed Only'**
  String get completedOnly;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} completed'**
  String completed(int completed, int total);

  /// No description provided for @quizStatistics.
  ///
  /// In en, this message translates to:
  /// **'Quiz Statistics'**
  String get quizStatistics;

  /// No description provided for @totalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Total Questions'**
  String get totalQuestions;

  /// No description provided for @correctAnswers.
  ///
  /// In en, this message translates to:
  /// **'Correct Answers'**
  String get correctAnswers;

  /// No description provided for @wrongAnswers.
  ///
  /// In en, this message translates to:
  /// **'Wrong Answers'**
  String get wrongAnswers;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @backToLessons.
  ///
  /// In en, this message translates to:
  /// **'Back to Lessons'**
  String get backToLessons;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get excellent;

  /// No description provided for @goodJob.
  ///
  /// In en, this message translates to:
  /// **'Good Job!'**
  String get goodJob;

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep Practicing!'**
  String get keepPracticing;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmation;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @educationalSelection.
  ///
  /// In en, this message translates to:
  /// **'Educational Selection'**
  String get educationalSelection;

  /// No description provided for @unknownStep.
  ///
  /// In en, this message translates to:
  /// **'Unknown step'**
  String get unknownStep;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
