import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/user.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';
import 'auth_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login({
    required String emailOrPhone,
    required String password,
    required String type,
    required String notiId,
    required String mobileId,
    required String mobileType,
  }) async {
    try {
      print('🔐 Starting login process...');
      
      final requestModel = LoginRequestModel(
        emailOrPhone: emailOrPhone,
        password: password,
        type: type,
        notiId: notiId,
        mobileId: mobileId,
        mobileType: mobileType,
      );

      print('📤 Login request data: ${requestModel.toJson()}');

      final response = await apiClient.post(
        AppConstants.loginEndpoint,
        data: requestModel.toJson(),
      );

      print('📥 Login response received: ${response.data}');

          if (response.statusCode == 200) {
            final loginResponse = LoginResponseModel.fromJson(response.data);

            if (loginResponse.status && loginResponse.data != null) {
              final loginData = loginResponse.data!;
              final userData = loginData.loginData;
              
              final userModel = UserModel(
                id: userData.id,
                name: userData.name,
                email: userData.email,
                isVip: userData.isVip,
                references: userData.references,
                points: userData.points,
                attendanceWeeks: userData.attendanceWeeks,
                phone: userData.phone,
                phoneVerified: userData.phoneVerified,
                countryCode: userData.countryCode,
                fakeNumber: userData.fakeNumber,
                type: userData.type,
                gendar: userData.gendar,
                mobileId: userData.mobileId,
                mobileType: userData.mobileType,
                img: userData.img,
                socialId: userData.socialId,
                username: userData.username,
                lock: userData.lock,
                lockMessage: userData.lockMessage,
                systemId: userData.systemId,
                stageId: userData.stageId,
                classroomId: userData.classroomId,
                termId: userData.termId,
                pathId: userData.pathId,
                institutionId: userData.institutionId,
                createdAt: userData.createdAt,
                updatedAt: userData.updatedAt,
                token: loginData.token,
                system: SystemInfo(
                  id: userData.system.id,
                  name: userData.system.name,
                ),
                stage: StageInfo(
                  id: userData.stage.id,
                  name: userData.stage.name,
                ),
                classroom: ClassroomInfo(
                  id: userData.classroom.id,
                  name: userData.classroom.name,
                ),
                term: TermInfo(
                  id: userData.term.id,
                  name: userData.term.name,
                ),
              );

              // Set auth token for future requests
              apiClient.setAuthToken(userModel.token);

              print('✅ Login successful for user: ${userModel.name}');
              return userModel;
            } else {
              print('❌ Login failed: ${loginResponse.message}');
              throw ServerFailure(loginResponse.message ?? 'Login failed');
            }
      } else {
        print('❌ Login request failed with status: ${response.statusCode}');
        throw ServerFailure('Login failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('🌐 Network error during login: ${e.message}');
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      print('💥 Unexpected login error: $e');
      throw ServerFailure('Unexpected error: ${e.toString()}');
    }
  }
}
