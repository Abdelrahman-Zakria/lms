import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/device_info_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  final DeviceInfoService deviceInfoService;

  LoginUseCase({
    required this.repository,
    required this.deviceInfoService,
  });

  Future<Either<Failure, User>> call({
    required String emailOrPhone,
    required String password,
    required String type,
  }) async {
    try {
      final mobileId = await deviceInfoService.getDeviceId();
      final mobileType = await deviceInfoService.getMobileType();
      final notiId = await deviceInfoService.getNotificationId();
      return await repository.login(
        emailOrPhone: emailOrPhone,
        password: password,
        type: type,
        notiId: notiId,
        mobileId: mobileId,
        mobileType: mobileType,
      );
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }
}


