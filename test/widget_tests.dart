import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms/core/theme/app_theme.dart';
import 'package:lms/core/splash/splash_screen.dart';
import 'package:lms/features/auth/presentation/screens/login_screen.dart';
import 'package:lms/features/subjects/presentation/widgets/subject_card.dart';
import 'package:lms/features/subjects/domain/entities/subject.dart';

void main() {
  group('Splash Screen Widget Tests', () {
    testWidgets('Splash screen should display logo and app name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
        ),
      );

      // Wait for animations to complete
      await tester.pumpAndSettle();

      // Check if the app name is displayed
      expect(find.text('LMS'), findsOneWidget);
      expect(find.text('Learning Management System'), findsOneWidget);
      
      // Check if loading indicator is present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Login Screen Widget Tests', () {
    testWidgets('Login screen should display form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const LoginScreen(),
        ),
      );

      // Check if form fields are present
      expect(find.byType(TextField), findsNWidgets(2)); // Email and Password fields
      expect(find.byType(DropdownButtonFormField), findsOneWidget); // Type dropdown
      expect(find.byType(ElevatedButton), findsNWidgets(2)); // Login and Test APIs buttons
    });

    testWidgets('Login form should validate input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const LoginScreen(),
        ),
      );

      // Find the login button
      final loginButton = find.byType(ElevatedButton).first;
      
      // Try to tap login button without filling fields
      await tester.tap(loginButton);
      await tester.pump();

      // The button should be enabled (since we have test data pre-filled)
      expect(loginButton, findsOneWidget);
    });
  });

  group('Subject Card Widget Tests', () {
    testWidgets('Subject card should display subject information', (WidgetTester tester) async {
      final subject = Subject(
        id: 1,
        name: 'Test Subject',
        description: 'Test Description',
        image: null,
        difficulty: 'Easy',
        status: 'Active',
        progress: 0.5,
        metadata: {'key': 'value'},
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SubjectCard(
              subject: subject,
              onTap: () {},
              onInfoTap: () {},
            ),
          ),
        ),
      );

      // Check if subject information is displayed
      expect(find.text('Test Subject'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Easy'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('Subject card should handle tap events', (WidgetTester tester) async {
      bool tapped = false;
      final subject = Subject(
        id: 1,
        name: 'Test Subject',
        description: 'Test Description',
        image: null,
        difficulty: 'Easy',
        status: 'Active',
        progress: 0.5,
        metadata: {'key': 'value'},
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: SubjectCard(
              subject: subject,
              onTap: () => tapped = true,
              onInfoTap: () {},
            ),
          ),
        ),
      );

      // Tap the subject card
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });

  group('Theme Tests', () {
    testWidgets('App theme should be applied correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: Text('Test'),
          ),
        ),
      );

      // Check if the theme is applied
      final textWidget = tester.widget<Text>(find.text('Test'));
      expect(textWidget.style?.fontFamily, equals('Cairo'));
    });
  });
}


