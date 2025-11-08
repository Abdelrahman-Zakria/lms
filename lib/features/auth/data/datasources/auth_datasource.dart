import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String emailOrPhone,
    required String password,
    required String type,
    required String notiId,
    required String mobileId,
    required String mobileType,
  });
}

abstract class AuthLocalDataSource {
  Future<UserModel?> getCurrentUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();
}
