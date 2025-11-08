// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نظام إدارة التعلم';

  @override
  String get welcome => 'مرحباً';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get emailOrPhone => 'البريد الإلكتروني أو الهاتف';

  @override
  String get emailOrPhoneHint => 'أدخل بريدك الإلكتروني أو رقم هاتفك';

  @override
  String get emailOrPhoneError => 'يرجى إدخال بريدك الإلكتروني أو رقم هاتفك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get passwordError => 'يرجى إدخال كلمة المرور';

  @override
  String get passwordMinLengthError => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get student => 'طالب';

  @override
  String get parent => 'ولي أمر';

  @override
  String get teacher => 'معلم';

  @override
  String get welcomeMessage => 'مرحباً بك في منصتنا التعليمية';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get selectEducationSystem => 'اختر نظام التعليم';

  @override
  String get selectEducationalStage => 'اختر المرحلة التعليمية';

  @override
  String get selectClassroomGrade => 'اختر الفصل/الصف';

  @override
  String get selectAcademicTerm => 'اختر الفصل الدراسي';

  @override
  String get selectEducationalTrack => 'اختر المسار التعليمي';

  @override
  String get back => 'رجوع';

  @override
  String get continueToSubjects => 'المتابعة إلى المواد';

  @override
  String get subjects => 'المواد';

  @override
  String subjectsFound(int count) {
    return 'تم العثور على $count مادة';
  }

  @override
  String get viewAllDetails => 'عرض جميع التفاصيل';

  @override
  String get searchSubjects => 'البحث في المواد...';

  @override
  String get noSubjectsAvailable => 'لا توجد مواد متاحة';

  @override
  String noSubjectsFound(String query) {
    return 'لم يتم العثور على مواد لـ \"$query\"';
  }

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get lessons => 'الدروس';

  @override
  String get searchLessons => 'البحث في الدروس...';

  @override
  String get noLessonsAvailable => 'لا توجد دروس متاحة';

  @override
  String noLessonsFound(String query) {
    return 'لم يتم العثور على دروس لـ \"$query\"';
  }

  @override
  String get completedOnly => 'المكتملة فقط';

  @override
  String completed(int completed, int total) {
    return '$completed/$total مكتمل';
  }

  @override
  String get quizStatistics => 'إحصائيات الاختبار';

  @override
  String get totalQuestions => 'إجمالي الأسئلة';

  @override
  String get correctAnswers => 'الإجابات الصحيحة';

  @override
  String get wrongAnswers => 'الإجابات الخاطئة';

  @override
  String get totalTime => 'الوقت الإجمالي';

  @override
  String get backToLessons => 'العودة إلى الدروس';

  @override
  String get excellent => 'ممتاز!';

  @override
  String get goodJob => 'عمل جيد!';

  @override
  String get keepPracticing => 'استمر في الممارسة!';

  @override
  String get logoutConfirmation => 'تسجيل الخروج';

  @override
  String get logoutConfirmationMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get refresh => 'تحديث';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get educationalSelection => 'الاختيار التعليمي';

  @override
  String get unknownStep => 'خطوة غير معروفة';

  @override
  String get general => 'عام';
}
