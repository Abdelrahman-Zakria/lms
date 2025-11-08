import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/usecases/get_lessons_usecase.dart';

class LessonsProvider extends ChangeNotifier {
  final GetLessonsUseCase getLessonsUseCase;

  LessonsProvider({required this.getLessonsUseCase});

  List<Lesson> _lessons = [];
  final Map<String, List<Lesson>> _lessonsByUnit = {};
  bool _isLoading = false;
  String? _errorMessage;

  List<Lesson> get lessons => _lessons;
  Map<String, List<Lesson>> get lessonsByUnit => _lessonsByUnit;
  List<String> get unitNames => _lessonsByUnit.keys.toList();
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

  Future<void> loadLessons(String subjectId) async {
    _setLoading(true);
    _setError(null);

    final result = await getLessonsUseCase(subjectId);

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (lessons) {
        _lessons = lessons;
        _organizeLessonsByUnit();
        notifyListeners();
      },
    );
  }

  void _organizeLessonsByUnit() {
    _lessonsByUnit.clear();
    
    for (final lesson in _lessons) {
      final unitName = lesson.unitName ?? 'General';
      if (!_lessonsByUnit.containsKey(unitName)) {
        _lessonsByUnit[unitName] = [];
      }
      _lessonsByUnit[unitName]!.add(lesson);
    }

    // Sort lessons within each unit by order
    for (final unitName in _lessonsByUnit.keys) {
      _lessonsByUnit[unitName]!.sort((a, b) {
        final orderA = a.order ?? 0;
        final orderB = b.order ?? 0;
        return orderA.compareTo(orderB);
      });
    }
  }

  List<Lesson> getLessonsForUnit(String unitName) {
    return _lessonsByUnit[unitName] ?? [];
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
