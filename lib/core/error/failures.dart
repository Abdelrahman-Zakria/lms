abstract class Failure {
  final String message;
  final int? code;

  const Failure(this.message, [this.code]);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.code]);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.code]);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.code]);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

class DeviceInfoFailure extends Failure {
  const DeviceInfoFailure(super.message, [super.code]);
}

