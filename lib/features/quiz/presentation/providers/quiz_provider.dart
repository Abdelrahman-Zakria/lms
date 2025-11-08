import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/usecases/quiz_usecases.dart';

class QuizProvider extends ChangeNotifier {
  final GetQuestionsUseCase getQuestionsUseCase;
  final SubmitAnswerUseCase submitAnswerUseCase;

  QuizProvider({
    required this.getQuestionsUseCase,
    required this.submitAnswerUseCase,
  });

  // Quiz State
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isQuizCompleted = false;
  QuizResult? _quizResult;

  // Current Question State
  int? _selectedAnswer;
  int _attempts = 0;
  int _questionStartTime = 0;
  int _questionTimeSpent = 0;
  bool _isAnswerSubmitted = false;
  bool _isAnswerCorrect = false;
  bool _showExplanation = false;

  // Timer
  int _timeRemaining = 0;
  bool _isTimerActive = false;

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion => _questions.isNotEmpty && _currentQuestionIndex < _questions.length 
      ? _questions[_currentQuestionIndex] 
      : null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isQuizCompleted => _isQuizCompleted;
  QuizResult? get quizResult => _quizResult;

  int? get selectedAnswer => _selectedAnswer;
  int get attempts => _attempts;
  int get timeRemaining => _timeRemaining;
  bool get isTimerActive => _isTimerActive;
  bool get isAnswerSubmitted => _isAnswerSubmitted;
  bool get isAnswerCorrect => _isAnswerCorrect;
  bool get showExplanation => _showExplanation;

  bool get canProceed => _isAnswerCorrect || _attempts >= AppConstants.maxAttempts;
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadQuestions(String lessonId) async {
    _setLoading(true);
    _setError(null);
    _resetQuizState();

    final result = await getQuestionsUseCase(lessonId);

    _setLoading(false);

    result.fold(
      (failure) => _setError(_getErrorMessage(failure)),
      (questions) {
        _questions = questions;
        if (questions.isNotEmpty) {
          _startQuestion();
        }
        notifyListeners();
      },
    );
  }

  void _resetQuizState() {
    _questions.clear();
    _currentQuestionIndex = 0;
    _isQuizCompleted = false;
    _quizResult = null;
    _resetQuestionState();
  }

  void _resetQuestionState() {
    _selectedAnswer = null;
    _attempts = 0;
    _questionStartTime = DateTime.now().millisecondsSinceEpoch;
    _questionTimeSpent = 0;
    _isAnswerSubmitted = false;
    _isAnswerCorrect = false;
    _showExplanation = false;
    _stopTimer();
  }

  void _startQuestion() {
    if (currentQuestion != null) {
      _questionStartTime = DateTime.now().millisecondsSinceEpoch;
      _timeRemaining = currentQuestion!.timeLimit ?? AppConstants.defaultQuestionTime;
      _startTimer();
    }
  }

  void _startTimer() {
    _isTimerActive = true;
    _updateTimer();
  }

  void _stopTimer() {
    _isTimerActive = false;
  }

  void _updateTimer() {
    if (_isTimerActive && _timeRemaining > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        if (_isTimerActive) {
          _timeRemaining--;
          notifyListeners();
          if (_timeRemaining <= 0) {
            _handleTimeUp();
          } else {
            _updateTimer();
          }
        }
      });
    }
  }

  void _handleTimeUp() {
    _stopTimer();
    _questionTimeSpent = DateTime.now().millisecondsSinceEpoch - _questionStartTime;
    _attempts = AppConstants.maxAttempts; // Mark as max attempts reached
    notifyListeners();
  }

  void selectAnswer(int answerIndex) {
    if (!_isAnswerSubmitted && _attempts < AppConstants.maxAttempts) {
      _selectedAnswer = answerIndex;
      notifyListeners();
    }
  }

  Future<void> submitAnswer() async {
    if (_selectedAnswer == null || _isAnswerSubmitted || _attempts >= AppConstants.maxAttempts) {
      return;
    }

    _stopTimer();
    _questionTimeSpent = DateTime.now().millisecondsSinceEpoch - _questionStartTime;
    _attempts++;
    _isAnswerSubmitted = true;
    _isAnswerCorrect = _selectedAnswer == currentQuestion!.correctAnswer;

    // Submit answer to server
    await _submitAnswerToServer();

    notifyListeners();
  }

  Future<void> _submitAnswerToServer() async {
    if (currentQuestion != null) {
      final result = await submitAnswerUseCase(
        answerTime: _questionTimeSpent ~/ 1000, // Convert to seconds
        answerNum: _attempts,
        questionId: currentQuestion!.id,
        isLast: isLastQuestion,
      );

      result.fold(
        (failure) => _setError(_getErrorMessage(failure)),
        (_) => {}, // Success
      );
    }
  }

  void displayExplanation() {
    if (_attempts >= AppConstants.maxAttempts) {
      _showExplanation = true;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (isLastQuestion) {
      _completeQuiz();
    } else {
      _currentQuestionIndex++;
      _resetQuestionState();
      _startQuestion();
      notifyListeners();
    }
  }

  void _completeQuiz() {
    _isQuizCompleted = true;
    _stopTimer();
    _calculateQuizResult();
    notifyListeners();
  }

  void _calculateQuizResult() {
    // This would typically be calculated based on stored results
    // For now, we'll create a basic result
    _quizResult = QuizResult(
      totalQuestions: _questions.length,
      correctAnswers: 0, // Would be calculated from actual results
      wrongAnswers: 0, // Would be calculated from actual results
      totalTime: 0, // Would be calculated from actual results
      score: 0.0, // Would be calculated from actual results
      questionResults: [], // Would be populated from actual results
    );
  }

  void retryQuestion() {
    if (_attempts < AppConstants.maxAttempts) {
      _resetQuestionState();
      _startQuestion();
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
