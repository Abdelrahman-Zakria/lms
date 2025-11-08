import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String emailOrPhone,
    required String password,
    required String type,
    required String notiId,
    required String mobileId,
    required String mobileType,
  });

  Future<Either<Failure, void>> logout();
  
  Future<Either<Failure, User?>> getCurrentUser();
  
  Future<Either<Failure, void>> saveUser(User user);
  
  Future<Either<Failure, void>> clearUser();
}

