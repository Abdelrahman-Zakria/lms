import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/auth_usecases.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  });

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _setUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<bool> login({
    required String emailOrPhone,
    required String password,
    required String type,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      print('🔐 AuthProvider: Starting login process...');
      
      final result = await loginUseCase(
        emailOrPhone: emailOrPhone,
        password: password,
        type: type,
      );

      return result.fold(
        (failure) {
          print('❌ AuthProvider: Login failed: ${failure.message}');
          _setError(_getErrorMessage(failure));
          return false;
        },
        (user) {
          print('✅ AuthProvider: Login successful for user: ${user.name}');
          _setUser(user);
          return true;
        },
      );
    } catch (e) {
      print('💥 AuthProvider: Unexpected login error: $e');
      _setError('Unexpected error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    _setError(null);

    final result = await logoutUseCase();

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (_) => _setUser(null),
    );
  }

  Future<void> checkAuthStatus() async {
    _setLoading(true);
    _setError(null);

    final result = await getCurrentUserUseCase();

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (user) => _setUser(user),
    );
  }

  void clearError() {
    _setError(null);
  }

  String _getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    } else if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else if (failure is DeviceInfoFailure) {
      return failure.message;
    } else {
      return 'An unexpected error occurred';
    }
  }
}
