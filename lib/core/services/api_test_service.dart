import 'dart:developer' as developer;
import '../network/api_client.dart';
import '../constants/app_constants.dart';
import '../utils/device_info_service.dart';

class ApiTestService {
  final ApiClient apiClient;
  final DeviceInfoService deviceInfoService;

  ApiTestService({
    required this.apiClient,
    required this.deviceInfoService,
  });

  /// Test Login API
  Future<void> testLoginAPI() async {
    developer.log('🔐 ========== TESTING LOGIN API ==========', name: 'LOGIN_API');
    try {
      // Get real device info
      final mobileId = await deviceInfoService.getDeviceId();
      final mobileType = await deviceInfoService.getMobileType();
      final notiId = await deviceInfoService.getNotificationId();

      developer.log('📱 Device Info:', name: 'LOGIN_API');
      developer.log('  - Mobile ID: $mobileId', name: 'LOGIN_API');
      developer.log('  - Mobile Type: $mobileType', name: 'LOGIN_API');
      developer.log('  - Notification ID: $notiId', name: 'LOGIN_API');

      final requestData = {
        'email_or_phone': '01029535630',
        'password': '123456',
        'type': 'child',
        'noti_id': notiId,
        'mobile_id': mobileId,
        'mobile_type': mobileType,
      };

      developer.log('📤 Request Data:', name: 'LOGIN_API');
      developer.log('  - email_or_phone: ${requestData['email_or_phone']}', name: 'LOGIN_API');
      developer.log('  - password: ${requestData['password']}', name: 'LOGIN_API');
      developer.log('  - type: ${requestData['type']}', name: 'LOGIN_API');
      developer.log('  - noti_id: ${requestData['noti_id']}', name: 'LOGIN_API');
      developer.log('  - mobile_id: ${requestData['mobile_id']}', name: 'LOGIN_API');
      developer.log('  - mobile_type: ${requestData['mobile_type']}', name: 'LOGIN_API');

      final response = await apiClient.post(AppConstants.loginEndpoint, data: requestData);

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'LOGIN_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'LOGIN_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'LOGIN_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'LOGIN_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Login Data Keys: ${data.keys}', name: 'LOGIN_API');
        developer.log('📥 Token: ${data['token']}', name: 'LOGIN_API');
        
        if (data['login_data'] != null) {
          final loginData = data['login_data'];
          developer.log('📥 User ID: ${loginData['id']}', name: 'LOGIN_API');
          developer.log('📥 User Name: ${loginData['name']}', name: 'LOGIN_API');
          developer.log('📥 User Email: ${loginData['email']}', name: 'LOGIN_API');
          developer.log('📥 User Type: ${loginData['type']}', name: 'LOGIN_API');
          developer.log('📥 System ID: ${loginData['system_id']}', name: 'LOGIN_API');
          developer.log('📥 Stage ID: ${loginData['stage_id']}', name: 'LOGIN_API');
          developer.log('📥 Classroom ID: ${loginData['classroom_id']}', name: 'LOGIN_API');
          developer.log('📥 Term ID: ${loginData['term_id']}', name: 'LOGIN_API');
          developer.log('📥 Path ID: ${loginData['path_id']}', name: 'LOGIN_API');
        }
      }

      developer.log('✅ Login API test completed successfully', name: 'LOGIN_API');
    } catch (e) {
      developer.log('❌ Login API test failed: $e', name: 'LOGIN_API');
    }
  }

  /// Test Education Systems API
  Future<void> testEducationSystemsAPI() async {
    developer.log('🏫 ========== TESTING EDUCATION SYSTEMS API ==========', name: 'EDUCATION_SYSTEMS_API');
    try {
      final response = await apiClient.post(AppConstants.educationSystemsEndpoint);

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'EDUCATION_SYSTEMS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'EDUCATION_SYSTEMS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'EDUCATION_SYSTEMS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'EDUCATION_SYSTEMS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Systems Count: ${data.length}', name: 'EDUCATION_SYSTEMS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 System $i: ${data[i]}', name: 'EDUCATION_SYSTEMS_API');
        }
      }

      developer.log('✅ Education Systems API test completed successfully', name: 'EDUCATION_SYSTEMS_API');
    } catch (e) {
      developer.log('❌ Education Systems API test failed: $e', name: 'EDUCATION_SYSTEMS_API');
    }
  }

  /// Test Education Stages API
  Future<void> testEducationStagesAPI() async {
    developer.log('🎓 ========== TESTING EDUCATION STAGES API ==========', name: 'EDUCATION_STAGES_API');
    try {
      final response = await apiClient.post(AppConstants.educationStagesEndpoint, data: {'system_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'EDUCATION_STAGES_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'EDUCATION_STAGES_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'EDUCATION_STAGES_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'EDUCATION_STAGES_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Stages Count: ${data.length}', name: 'EDUCATION_STAGES_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Stage $i: ${data[i]}', name: 'EDUCATION_STAGES_API');
        }
      }

      developer.log('✅ Education Stages API test completed successfully', name: 'EDUCATION_STAGES_API');
    } catch (e) {
      developer.log('❌ Education Stages API test failed: $e', name: 'EDUCATION_STAGES_API');
    }
  }

  /// Test Classrooms API
  Future<void> testClassroomsAPI() async {
    developer.log('🏫 ========== TESTING CLASSROOMS API ==========', name: 'CLASSROOMS_API');
    try {
      final response = await apiClient.post(AppConstants.classroomsEndpoint, data: {'stage_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'CLASSROOMS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'CLASSROOMS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'CLASSROOMS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'CLASSROOMS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Classrooms Count: ${data.length}', name: 'CLASSROOMS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Classroom $i: ${data[i]}', name: 'CLASSROOMS_API');
        }
      }

      developer.log('✅ Classrooms API test completed successfully', name: 'CLASSROOMS_API');
    } catch (e) {
      developer.log('❌ Classrooms API test failed: $e', name: 'CLASSROOMS_API');
    }
  }

  /// Test Terms API
  Future<void> testTermsAPI() async {
    developer.log('📅 ========== TESTING TERMS API ==========', name: 'TERMS_API');
    try {
      final response = await apiClient.post(AppConstants.termsEndpoint, data: {'classroom_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'TERMS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'TERMS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'TERMS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'TERMS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Terms Count: ${data.length}', name: 'TERMS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Term $i: ${data[i]}', name: 'TERMS_API');
        }
      }

      developer.log('✅ Terms API test completed successfully', name: 'TERMS_API');
    } catch (e) {
      developer.log('❌ Terms API test failed: $e', name: 'TERMS_API');
    }
  }

  /// Test Paths API
  Future<void> testPathsAPI() async {
    developer.log('🛤️ ========== TESTING PATHS API ==========', name: 'PATHS_API');
    try {
      final response = await apiClient.post(AppConstants.pathsEndpoint, data: {'classroom_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'PATHS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'PATHS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'PATHS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'PATHS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Paths Count: ${data.length}', name: 'PATHS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Path $i: ${data[i]}', name: 'PATHS_API');
        }
      }

      developer.log('✅ Paths API test completed successfully', name: 'PATHS_API');
    } catch (e) {
      developer.log('❌ Paths API test failed: $e', name: 'PATHS_API');
    }
  }

  /// Test Subjects API
  Future<void> testSubjectsAPI() async {
    developer.log('📚 ========== TESTING SUBJECTS API ==========', name: 'SUBJECTS_API');
    try {
      final response = await apiClient.post(AppConstants.subjectsEndpoint, data: {
        'child_id': 1,
        'term_id': 1,
        'path_id': 1,
      });

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'SUBJECTS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'SUBJECTS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'SUBJECTS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'SUBJECTS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Subjects Count: ${data.length}', name: 'SUBJECTS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Subject $i: ${data[i]}', name: 'SUBJECTS_API');
        }
      }

      developer.log('✅ Subjects API test completed successfully', name: 'SUBJECTS_API');
    } catch (e) {
      developer.log('❌ Subjects API test failed: $e', name: 'SUBJECTS_API');
    }
  }

  /// Test Lessons API
  Future<void> testLessonsAPI() async {
    developer.log('📖 ========== TESTING LESSONS API ==========', name: 'LESSONS_API');
    try {
      final response = await apiClient.post(AppConstants.lessonsEndpoint, data: {'subject_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'LESSONS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'LESSONS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'LESSONS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'LESSONS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Lessons Count: ${data.length}', name: 'LESSONS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Lesson $i: ${data[i]}', name: 'LESSONS_API');
        }
      }

      developer.log('✅ Lessons API test completed successfully', name: 'LESSONS_API');
    } catch (e) {
      developer.log('❌ Lessons API test failed: $e', name: 'LESSONS_API');
    }
  }

  /// Test Questions API
  Future<void> testQuestionsAPI() async {
    developer.log('❓ ========== TESTING QUESTIONS API ==========', name: 'QUESTIONS_API');
    try {
      final response = await apiClient.post(AppConstants.questionsEndpoint, data: {'lesson_id': 1});

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'QUESTIONS_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'QUESTIONS_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'QUESTIONS_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'QUESTIONS_API');

      if (response.data['data'] != null) {
        final data = response.data['data'];
        developer.log('📥 Questions Count: ${data.length}', name: 'QUESTIONS_API');
        for (int i = 0; i < data.length && i < 3; i++) {
          developer.log('📥 Question $i: ${data[i]}', name: 'QUESTIONS_API');
        }
      }

      developer.log('✅ Questions API test completed successfully', name: 'QUESTIONS_API');
    } catch (e) {
      developer.log('❌ Questions API test failed: $e', name: 'QUESTIONS_API');
    }
  }

  /// Test Answer API
  Future<void> testAnswerAPI() async {
    developer.log('✅ ========== TESTING ANSWER API ==========', name: 'ANSWER_API');
    try {
      final response = await apiClient.post(AppConstants.answerEndpoint, data: {
        'answer_time': 30,
        'answer_num': 1,
        'question_id': 1,
        'is_last': false,
      });

      developer.log('📥 Response Type: ${response.runtimeType}', name: 'ANSWER_API');
      developer.log('📥 Response Data Keys: ${response.data.keys}', name: 'ANSWER_API');
      developer.log('📥 Response Status: ${response.data['status']}', name: 'ANSWER_API');
      developer.log('📥 Response Message: ${response.data['message']}', name: 'ANSWER_API');

      developer.log('✅ Answer API test completed successfully', name: 'ANSWER_API');
    } catch (e) {
      developer.log('❌ Answer API test failed: $e', name: 'ANSWER_API');
    }
  }

  /// Run all API tests
  Future<void> runAllTests() async {
    developer.log('🚀 ========== RUNNING ALL API TESTS ==========', name: 'API_TESTS');
    
    await testLoginAPI();
    await testEducationSystemsAPI();
    await testEducationStagesAPI();
    await testClassroomsAPI();
    await testTermsAPI();
    await testPathsAPI();
    await testSubjectsAPI();
    await testLessonsAPI();
    await testQuestionsAPI();
    await testAnswerAPI();
    
    developer.log('🎉 ========== ALL API TESTS COMPLETED ==========', name: 'API_TESTS');
  }
}