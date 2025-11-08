import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}

