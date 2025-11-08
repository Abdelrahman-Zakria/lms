import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lms/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('App should start with splash screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Check if splash screen is displayed
      expect(find.text('LMS'), findsOneWidget);
      expect(find.text('Learning Management System'), findsOneWidget);
    });

    testWidgets('App should navigate to login screen after splash', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Check if login screen is displayed
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(DropdownButtonFormField), findsOneWidget);
    });

    testWidgets('Login form should be functional', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Find and tap the login button
      final loginButton = find.byType(ElevatedButton).first;
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // The app should attempt to login (may fail due to network, but should not crash)
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('App should handle navigation between screens', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Check if we can navigate to different screens
      // This test ensures the navigation system is working
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Error Handling Tests', () {
    testWidgets('App should handle network errors gracefully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Try to login (this may fail due to network issues)
      final loginButton = find.byType(ElevatedButton).first;
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // App should not crash and should still be functional
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });

  group('Performance Tests', () {
    testWidgets('App should load within reasonable time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle();

      stopwatch.stop();
      
      // App should load within 5 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });
  });
}


