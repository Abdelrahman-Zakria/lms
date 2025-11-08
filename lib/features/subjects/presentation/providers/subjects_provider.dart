import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/subject.dart';
import '../../domain/usecases/get_subjects_usecase.dart';

class SubjectsProvider extends ChangeNotifier {
  final GetSubjectsUseCase getSubjectsUseCase;

  SubjectsProvider({required this.getSubjectsUseCase});

  List<Subject> _subjects = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Subject> get subjects => _subjects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadSubjects({
    required String childId,
    required String termId,
    String? pathId,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await getSubjectsUseCase(
      childId: childId,
      termId: termId,
      pathId: pathId,
    );

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (subjects) {
        _subjects = subjects;
        notifyListeners();
      },
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
    } else {
      return 'An unexpected error occurred';
    }
  }
}
