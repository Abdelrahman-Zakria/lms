import 'package:flutter_test/flutter_test.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/theme/app_theme.dart';
import 'package:lms/features/auth/domain/entities/user.dart';

void main() {
  group('App Constants Tests', () {
    test('API endpoints should be properly defined', () {
      expect(AppConstants.baseUrl, isNotEmpty);
      expect(AppConstants.loginEndpoint, isNotEmpty);
      expect(AppConstants.subjectsEndpoint, isNotEmpty);
      expect(AppConstants.lessonsEndpoint, isNotEmpty);
      expect(AppConstants.questionsEndpoint, isNotEmpty);
      expect(AppConstants.answerEndpoint, isNotEmpty);
    });

    test('Storage keys should be properly defined', () {
      expect(AppConstants.tokenKey, isNotEmpty);
      expect(AppConstants.userDataKey, isNotEmpty);
    });

    test('UI constants should have valid values', () {
      expect(AppConstants.defaultPadding, greaterThan(0));
      expect(AppConstants.maxAttempts, greaterThan(0));
      expect(AppConstants.maxAttempts, greaterThan(0));
    });
  });

  group('App Theme Tests', () {
    test('Theme should be properly configured', () {
      final theme = AppTheme.lightTheme;
      expect(theme, isNotNull);
      expect(theme.textTheme.bodyLarge?.fontFamily, equals('Cairo'));
      expect(theme.useMaterial3, isTrue);
    });

    test('Color scheme should be properly defined', () {
      expect(AppTheme.primaryColor, isNotNull);
      expect(AppTheme.secondaryColor, isNotNull);
      expect(AppTheme.accentColor, isNotNull);
      expect(AppTheme.errorColor, isNotNull);
      expect(AppTheme.successColor, isNotNull);
      expect(AppTheme.warningColor, isNotNull);
    });
  });

  group('User Entity Tests', () {
    test('User entity should be properly constructed', () {
      final user = User(
        id: 1,
        name: 'Test User',
        email: 'test@example.com',
        isVip: false,
        references: 0,
        points: 0,
        attendanceWeeks: 0,
        phone: '1234567890',
        phoneVerified: 1,
        countryCode: '+1',
        fakeNumber: 0,
        type: 'child',
        gendar: 'male',
        mobileId: 'test_mobile_id',
        mobileType: 'android',
        img: null,
        socialId: null,
        username: 'testuser',
        lock: 'unlocked',
        lockMessage: null,
        systemId: 1,
        stageId: 1,
        classroomId: 1,
        termId: 1,
        pathId: 1,
        institutionId: 1,
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        token: 'test_token',
        system: SystemInfo(id: 1, name: 'Test System'),
        stage: StageInfo(id: 1, name: 'Test Stage'),
        classroom: ClassroomInfo(id: 1, name: 'Test Classroom'),
        term: TermInfo(id: 1, name: 'Test Term'),
      );

      expect(user.id, equals(1));
      expect(user.name, equals('Test User'));
      expect(user.email, equals('test@example.com'));
      expect(user.token, equals('test_token'));
    });

    test('SystemInfo should be properly constructed', () {
      final systemInfo = SystemInfo(id: 1, name: 'Test System');
      expect(systemInfo.id, equals(1));
      expect(systemInfo.name, equals('Test System'));
    });

    test('StageInfo should be properly constructed', () {
      final stageInfo = StageInfo(id: 1, name: 'Test Stage');
      expect(stageInfo.id, equals(1));
      expect(stageInfo.name, equals('Test Stage'));
    });

    test('ClassroomInfo should be properly constructed', () {
      final classroomInfo = ClassroomInfo(id: 1, name: 'Test Classroom');
      expect(classroomInfo.id, equals(1));
      expect(classroomInfo.name, equals('Test Classroom'));
    });

    test('TermInfo should be properly constructed', () {
      final termInfo = TermInfo(id: 1, name: 'Test Term');
      expect(termInfo.id, equals(1));
      expect(termInfo.name, equals('Test Term'));
    });
  });
}
