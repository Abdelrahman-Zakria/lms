import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_test_service.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_display.dart';
import '../widgets/answer_options.dart';
import '../widgets/quiz_progress.dart';
import '../widgets/quiz_timer.dart';
import '../widgets/quiz_results.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../../../lessons/domain/entities/lesson.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Test Quiz APIs when screen loads
      getIt<ApiTestService>().testQuestionsAPI();
      getIt<ApiTestService>().testAnswerAPI();
      _loadQuestions();
    });
  }

  void _loadQuestions() {
    final quizProvider = context.read<QuizProvider>();
    quizProvider.loadQuestions(widget.lesson.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const AppDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.lesson.title),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => _showExitDialog(),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isLoading) {
            return const LoadingWidget();
          }

          if (quizProvider.errorMessage != null) {
            return custom.ErrorWidget(
              message: quizProvider.errorMessage!,
              onRetry: () {
                quizProvider.clearError();
                _loadQuestions();
              },
            );
          }

          if (quizProvider.isQuizCompleted) {
            return QuizResults(
              result: quizProvider.quizResult!,
              onRetake: () {
                quizProvider.loadQuestions(widget.lesson.id.toString());
              },
              onBackToLessons: () {
                Navigator.of(context).pop();
              },
            );
          }

          final currentQuestion = quizProvider.currentQuestion;
          if (currentQuestion == null) {
            return const Center(
              child: Text('No questions available'),
            );
          }

          return Column(
            children: [
              // Quiz Progress
              QuizProgress(
                currentQuestion: quizProvider.currentQuestionIndex + 1,
                totalQuestions: quizProvider.questions.length,
                progress: (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length,
              ),
              
              // Quiz Timer
              QuizTimer(
                timeRemaining: quizProvider.timeRemaining,
                isActive: quizProvider.isTimerActive,
              ),
              
              // Question Display
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    children: [
                      // Question Number and Attempts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.questions.length}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppTheme.accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (quizProvider.attempts > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.warningColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Attempt ${quizProvider.attempts}/${AppConstants.maxAttempts}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: AppConstants.defaultPadding),
                      
                      // Question Content
                      QuestionDisplay(
                        question: currentQuestion,
                      ),
                      
                      const SizedBox(height: AppConstants.defaultPadding),
                      
                      // Answer Options
                      AnswerOptions(
                        question: currentQuestion,
                        selectedAnswer: quizProvider.selectedAnswer,
                        isAnswerSubmitted: quizProvider.isAnswerSubmitted,
                        isAnswerCorrect: quizProvider.isAnswerCorrect,
                        onAnswerSelected: quizProvider.selectAnswer,
                      ),
                      
                      const SizedBox(height: AppConstants.defaultPadding),
                      
                      // Action Buttons
                      _buildActionButtons(quizProvider),
                      
                      // Explanation (if shown)
                      if (quizProvider.showExplanation && currentQuestion.explanation != null)
                        _buildExplanation(currentQuestion.explanation!),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(QuizProvider quizProvider) {
    return Column(
      children: [
        // Check Answer Button
        if (!quizProvider.isAnswerSubmitted && quizProvider.selectedAnswer != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: quizProvider.submitAnswer,
              icon: const Icon(Icons.check),
              label: const Text('Check Answer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        
        // Retry Button (if wrong answer and attempts remaining)
        if (quizProvider.isAnswerSubmitted && 
            !quizProvider.isAnswerCorrect && 
            quizProvider.attempts < AppConstants.maxAttempts)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: quizProvider.retryQuestion,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.warningColor,
                side: const BorderSide(color: AppTheme.warningColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        
        // Next Question Button
        if (quizProvider.canProceed)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: quizProvider.nextQuestion,
              icon: Icon(quizProvider.isLastQuestion ? Icons.check_circle : Icons.arrow_forward),
              label: Text(quizProvider.isLastQuestion ? 'Finish Quiz' : 'Next Question'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successColor,
                foregroundColor: AppTheme.secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        
        // Show Explanation Button (after max attempts)
        if (quizProvider.isAnswerSubmitted && 
            !quizProvider.isAnswerCorrect && 
            quizProvider.attempts >= AppConstants.maxAttempts &&
            !quizProvider.showExplanation)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: quizProvider.displayExplanation,
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Show Explanation'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentColor,
                side: const BorderSide(color: AppTheme.accentColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExplanation(String explanation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb,
                color: AppTheme.warningColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Explanation',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.warningColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Quiz'),
        content: const Text('Are you sure you want to exit the quiz? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue Quiz'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
