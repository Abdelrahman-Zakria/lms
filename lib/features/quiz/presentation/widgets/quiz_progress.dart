import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class QuizProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final double progress;

  const QuizProgress({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.accentColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Progress Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quiz Progress',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
              ),
              Text(
                '$currentQuestion / $totalQuestions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentColor,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.accentColor.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            minHeight: 8,
          ),
          
          const SizedBox(height: 8),
          
          // Progress Percentage
          Text(
            '${(progress * 100).toInt()}% Complete',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.accentColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}


