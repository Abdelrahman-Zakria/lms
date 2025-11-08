import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';
import 'auth_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = sharedPreferences.getString(AppConstants.userDataKey);
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      throw CacheFailure('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await sharedPreferences.setString(AppConstants.userDataKey, userJson);
      
      await sharedPreferences.setString(AppConstants.tokenKey, user.token);
    } catch (e) {
      throw CacheFailure('Failed to save user: ${e.toString()}');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(AppConstants.userDataKey);
      await sharedPreferences.remove(AppConstants.tokenKey);
    } catch (e) {
      throw CacheFailure('Failed to clear user: ${e.toString()}');
    }
  }
}
