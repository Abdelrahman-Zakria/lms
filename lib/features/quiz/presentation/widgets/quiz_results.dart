import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/quiz_result.dart';

class QuizResults extends StatelessWidget {
  final QuizResult result;
  final VoidCallback onRetake;
  final VoidCallback onBackToLessons;

  const QuizResults({
    super.key,
    required this.result,
    required this.onRetake,
    required this.onBackToLessons,
  });

  @override
  Widget build(BuildContext context) {
    final scorePercentage = (result.score * 100).toInt();
    final isPassing = scorePercentage >= 70; // 70% passing grade

    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isPassing
                        ? [
                            AppTheme.successColor.withOpacity(0.1),
                            AppTheme.successColor.withOpacity(0.05),
                          ]
                        : [
                            AppTheme.errorColor.withOpacity(0.1),
                            AppTheme.errorColor.withOpacity(0.05),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Result Icon
                    Icon(
                      isPassing ? Icons.celebration : Icons.sentiment_dissatisfied,
                      size: 64,
                      color: isPassing ? AppTheme.successColor : AppTheme.errorColor,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Result Title
                    Text(
                      isPassing ? 'Congratulations!' : 'Keep Trying!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isPassing ? AppTheme.successColor : AppTheme.errorColor,
                          ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Score
                    Text(
                      'Your Score: $scorePercentage%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Statistics
              Expanded(
                child: Column(
                  children: [
                    // Statistics Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Correct',
                            result.correctAnswers.toString(),
                            AppTheme.successColor,
                            Icons.check_circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Wrong',
                            result.wrongAnswers.toString(),
                            AppTheme.errorColor,
                            Icons.cancel,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Total',
                            result.totalQuestions.toString(),
                            AppTheme.primaryColor,
                            Icons.quiz,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Time',
                            _formatTime(result.totalTime),
                            AppTheme.accentColor,
                            Icons.timer,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.defaultPadding),
                    
                    // Detailed Results
                    if (result.questionResults.isNotEmpty)
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question Results',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryColor,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: result.questionResults.length,
                                    itemBuilder: (context, index) {
                                      final questionResult = result.questionResults[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: questionResult.isCorrect
                                              ? AppTheme.successColor.withOpacity(0.1)
                                              : AppTheme.errorColor.withOpacity(0.1),
                                          child: Icon(
                                            questionResult.isCorrect
                                                ? Icons.check
                                                : Icons.close,
                                            color: questionResult.isCorrect
                                                ? AppTheme.successColor
                                                : AppTheme.errorColor,
                                          ),
                                        ),
                                        title: Text(
                                          'Question ${index + 1}',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        subtitle: Text(
                                          'Time: ${questionResult.timeSpent}s, Attempts: ${questionResult.attempts}',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppTheme.accentColor,
                                              ),
                                        ),
                                        trailing: Text(
                                          questionResult.isCorrect ? 'Correct' : 'Wrong',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: questionResult.isCorrect
                                                    ? AppTheme.successColor
                                                    : AppTheme.errorColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onRetake,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retake Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onBackToLessons,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Lessons'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.accentColor,
                        side: const BorderSide(color: AppTheme.accentColor),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.accentColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}


