import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressIndicator({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentQuestion / totalQuestions;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            Text(
              '$currentQuestion / $totalQuestions',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppTheme.accentColor.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          minHeight: 8,
        ),
      ],
    );
  }
}


