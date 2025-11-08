import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:lms/l10n/app_localizations.dart' as gen;
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/localization/locale_provider.dart';
import 'core/utils/dependency_injection.dart';
import 'core/splash/splash_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/quiz/presentation/screens/quiz_screen.dart';
import 'features/subjects/presentation/providers/subjects_provider.dart';
import 'features/subjects/presentation/screens/subjects_screen.dart';
import 'features/lessons/presentation/providers/lessons_provider.dart';
import 'features/lessons/presentation/screens/lessons_screen.dart';
import 'features/quiz/presentation/providers/quiz_provider.dart';
import 'features/subjects/domain/entities/subject.dart';
import 'features/lessons/domain/entities/lesson.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // System UI overlay style will be set based on theme
  
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => getIt<AuthProvider>(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => getIt<HomeProvider>(),
        ),
        ChangeNotifierProvider<SubjectsProvider>(
          create: (_) => getIt<SubjectsProvider>(),
        ),
        ChangeNotifierProvider<LessonsProvider>(
          create: (_) => getIt<LessonsProvider>(),
        ),
        ChangeNotifierProvider<QuizProvider>(
          create: (_) => getIt<QuizProvider>(),
        ),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, localeProvider, themeProvider, child) {
          return MaterialApp(
            title: 'LMS - Learning Management System',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            localizationsDelegates: const [
              gen.AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            home: const SplashScreen(),
            routes: {
              '/auth': (context) => const AuthWrapper(),
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/subjects': (context) => const SubjectsScreen(),
              '/lessons': (context) {
                final subject = ModalRoute.of(context)!.settings.arguments as Subject;
                return LessonsScreen(subject: subject);
              },
              '/quiz': (context) {
                final lesson = ModalRoute.of(context)!.settings.arguments as Lesson;
                return QuizScreen(lesson: lesson);
              },
            },
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (authProvider.isAuthenticated) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}

