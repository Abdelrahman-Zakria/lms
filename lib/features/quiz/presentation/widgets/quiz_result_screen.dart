import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../domain/entities/quiz_result.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizResult result;
  final VoidCallback onBackToLessons;

  const QuizResultScreen({
    super.key,
    required this.result,
    required this.onBackToLessons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.largePadding),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Column(
                  children: [
                    // Score Circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: _getScoreColor(result.score).withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _getScoreColor(result.score),
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${result.score.toInt()}%',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: _getScoreColor(result.score),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppConstants.defaultPadding),

                    Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) {
                        final localizations = AppLocalizations.of(context);
                        return Text(
                          _getScoreMessage(result.score, localizations),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.largePadding),

              // Statistics
              Expanded(
                child: Column(
                  children: [
                    Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) {
                        final localizations = AppLocalizations.of(context);
                        return Text(
                          localizations?.quizStatistics ?? 'Quiz Statistics',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppConstants.defaultPadding),

                    // Stats Cards
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: AppConstants.defaultPadding,
                        mainAxisSpacing: AppConstants.defaultPadding,
                        children: [
                          Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return _buildStatCard(
                                context,
                                localizations?.totalQuestions ?? 'Total Questions',
                                result.totalQuestions.toString(),
                                Icons.quiz,
                                AppTheme.primaryColor,
                              );
                            },
                          ),
                          Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return _buildStatCard(
                                context,
                                localizations?.correctAnswers ?? 'Correct Answers',
                                result.correctAnswers.toString(),
                                Icons.check_circle,
                                AppTheme.successColor,
                              );
                            },
                          ),
                          Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return _buildStatCard(
                                context,
                                localizations?.wrongAnswers ?? 'Wrong Answers',
                                result.wrongAnswers.toString(),
                                Icons.cancel,
                                AppTheme.errorColor,
                              );
                            },
                          ),
                          Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return _buildStatCard(
                                context,
                                localizations?.totalTime ?? 'Total Time',
                                '${result.totalTime ~/ 60}m ${result.totalTime % 60}s',
                                Icons.access_time,
                                AppTheme.warningColor,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: Consumer<LocaleProvider>(
                  builder: (context, localeProvider, child) {
                    final localizations = AppLocalizations.of(context);
                    return ElevatedButton(
                      onPressed: onBackToLessons,
                      child: Text(localizations?.backToLessons ?? 'Back to Lessons'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.accentColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) {
      return AppTheme.successColor;
    } else if (score >= 60) {
      return AppTheme.warningColor;
    } else {
      return AppTheme.errorColor;
    }
  }

  String _getScoreMessage(double score, AppLocalizations? localizations) {
    if (score >= 80) {
      return localizations?.excellent ?? 'Excellent!';
    } else if (score >= 60) {
      return localizations?.goodJob ?? 'Good Job!';
    } else {
      return localizations?.keepPracticing ?? 'Keep Practicing!';
    }
  }
}


