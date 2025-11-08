import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/education_system.dart';
import '../../domain/entities/education_stage.dart';
import '../../domain/entities/classroom.dart';
import '../../domain/entities/term.dart';
import '../../domain/entities/path.dart';
import '../../domain/usecases/home_usecases.dart';

class HomeProvider extends ChangeNotifier {
  final GetEducationSystemsUseCase getEducationSystemsUseCase;
  final GetEducationStagesUseCase getEducationStagesUseCase;
  final GetClassroomsUseCase getClassroomsUseCase;
  final GetTermsUseCase getTermsUseCase;
  final GetPathsUseCase getPathsUseCase;

  HomeProvider({
    required this.getEducationSystemsUseCase,
    required this.getEducationStagesUseCase,
    required this.getClassroomsUseCase,
    required this.getTermsUseCase,
    required this.getPathsUseCase,
  });

  // State variables
  List<EducationSystem> _educationSystems = [];
  List<EducationStage> _educationStages = [];
  List<Classroom> _classrooms = [];
  List<Term> _terms = [];
  List<Path> _paths = [];

  EducationSystem? _selectedSystem;
  EducationStage? _selectedStage;
  Classroom? _selectedClassroom;
  Term? _selectedTerm;
  Path? _selectedPath;

  bool _isLoading = false;
  String? _errorMessage;
  int _currentStep = 0;

  // Getters
  List<EducationSystem> get educationSystems => _educationSystems;
  List<EducationStage> get educationStages => _educationStages;
  List<Classroom> get classrooms => _classrooms;
  List<Term> get terms => _terms;
  List<Path> get paths => _paths;

  EducationSystem? get selectedSystem => _selectedSystem;
  EducationStage? get selectedStage => _selectedStage;
  Classroom? get selectedClassroom => _selectedClassroom;
  Term? get selectedTerm => _selectedTerm;
  Path? get selectedPath => _selectedPath;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentStep => _currentStep;

  bool get canProceedToSubjects {
    return _selectedSystem != null &&
        _selectedStage != null &&
        _selectedClassroom != null &&
        _selectedTerm != null;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadEducationSystems() async {
    _setLoading(true);
    _setError(null);

    try {
      print('🏫 HomeProvider: Loading education systems...');
      final result = await getEducationSystemsUseCase();

      result.fold(
        (failure) {
          print('❌ HomeProvider: Failed to load education systems: ${failure.message}');
          _setError(_getErrorMessage(failure));
        },
        (systems) {
          print('✅ HomeProvider: Successfully loaded ${systems.length} education systems');
          _educationSystems = systems;
          notifyListeners();
        },
      );
    } catch (e) {
      print('💥 HomeProvider: Unexpected error loading education systems: $e');
      _setError('Unexpected error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> selectSystem(EducationSystem system) async {
    _selectedSystem = system;
    _currentStep = 1;
    _educationStages.clear();
    _classrooms.clear();
    _terms.clear();
    _paths.clear();
    _selectedStage = null;
    _selectedClassroom = null;
    _selectedTerm = null;
    _selectedPath = null;

    _setLoading(true);
    _setError(null);

    final result = await getEducationStagesUseCase(system.id);

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (stages) {
        _educationStages = stages;
        notifyListeners();
      },
    );
  }

  Future<void> selectStage(EducationStage stage) async {
    _selectedStage = stage;
    _currentStep = 2;
    _classrooms.clear();
    _terms.clear();
    _paths.clear();
    _selectedClassroom = null;
    _selectedTerm = null;
    _selectedPath = null;

    _setLoading(true);
    _setError(null);

    final result = await getClassroomsUseCase(stage.id);

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (classrooms) {
        _classrooms = classrooms;
        notifyListeners();
      },
    );
  }

  Future<void> selectClassroom(Classroom classroom) async {
    _selectedClassroom = classroom;
    _currentStep = 3;
    _terms.clear();
    _paths.clear();
    _selectedTerm = null;
    _selectedPath = null;

    _setLoading(true);
    _setError(null);

    // Load terms and paths in parallel
    final termsResult = await getTermsUseCase(classroom.id);
    final pathsResult = await getPathsUseCase(classroom.id);

    _setLoading(false);

    termsResult.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (terms) {
        _terms = terms;
        notifyListeners();
      },
    );

    pathsResult.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (paths) {
        _paths = paths;
        notifyListeners();
      },
    );
  }

  void selectTerm(Term term) {
    _selectedTerm = term;
    _currentStep = 4;
    notifyListeners();
  }

  void selectPath(Path path) {
    _selectedPath = path;
    notifyListeners();
  }

  void goBack() {
    if (_currentStep > 0) {
      _currentStep--;
      
      // Clear subsequent selections
      switch (_currentStep) {
        case 0:
          _selectedSystem = null;
          _educationStages.clear();
          _classrooms.clear();
          _terms.clear();
          _paths.clear();
          _selectedStage = null;
          _selectedClassroom = null;
          _selectedTerm = null;
          _selectedPath = null;
          break;
        case 1:
          _selectedStage = null;
          _classrooms.clear();
          _terms.clear();
          _paths.clear();
          _selectedClassroom = null;
          _selectedTerm = null;
          _selectedPath = null;
          break;
        case 2:
          _selectedClassroom = null;
          _terms.clear();
          _paths.clear();
          _selectedTerm = null;
          _selectedPath = null;
          break;
        case 3:
          _selectedTerm = null;
          _selectedPath = null;
          break;
      }
      
      notifyListeners();
    }
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
