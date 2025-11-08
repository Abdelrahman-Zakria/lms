import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/device_info_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;
  final AuthLocalDataSourceImpl localDataSource;
  final DeviceInfoService deviceInfoService;
  final ApiClient apiClient;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.deviceInfoService,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, User>> login({
    required String emailOrPhone,
    required String password,
    required String type,
    required String notiId,
    required String mobileId,
    required String mobileType,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        emailOrPhone: emailOrPhone,
        password: password,
        type: type,
        notiId: notiId,
        mobileId: mobileId,
        mobileType: mobileType,
      );

      await localDataSource.saveUser(userModel);
      
      // Set auth token for future requests
      apiClient.setAuthToken(userModel.token);
      
      return Right(userModel);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearUser();
      // Clear auth token
      apiClient.clearAuthToken();
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure('Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getCurrentUser();
      
      // Set auth token if user exists
      if (userModel != null) {
        apiClient.setAuthToken(userModel.token);
      } else {
        apiClient.clearAuthToken();
      }
      
      return Right(userModel);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure('Failed to get current user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await localDataSource.saveUser(userModel);
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure('Failed to save user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearUser() async {
    try {
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure('Failed to clear user: ${e.toString()}'));
    }
  }
}
