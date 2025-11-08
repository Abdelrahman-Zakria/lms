import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/question.dart';

class AnswerOptions extends StatelessWidget {
  final Question question;
  final int? selectedAnswer;
  final bool isAnswerSubmitted;
  final bool isAnswerCorrect;
  final Function(int) onAnswerSelected;

  const AnswerOptions({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.isAnswerSubmitted,
    required this.isAnswerCorrect,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your answer:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
        ),
        
        const SizedBox(height: AppConstants.defaultPadding),
        
        ...question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = selectedAnswer == index;
          final isCorrect = index == question.correctAnswer;
          final showCorrectAnswer = isAnswerSubmitted && isCorrect;
          final showWrongAnswer = isAnswerSubmitted && isSelected && !isCorrect;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildAnswerOption(
              context,
              index,
              option,
              isSelected,
              showCorrectAnswer,
              showWrongAnswer,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnswerOption(
    BuildContext context,
    int index,
    String option,
    bool isSelected,
    bool showCorrectAnswer,
    bool showWrongAnswer,
  ) {
    Color backgroundColor = AppTheme.secondaryColor;
    Color borderColor = AppTheme.accentColor.withOpacity(0.3);
    Color textColor = AppTheme.primaryColor;
    IconData? icon;

    if (showCorrectAnswer) {
      backgroundColor = AppTheme.successColor.withOpacity(0.1);
      borderColor = AppTheme.successColor;
      textColor = AppTheme.successColor;
      icon = Icons.check_circle;
    } else if (showWrongAnswer) {
      backgroundColor = AppTheme.errorColor.withOpacity(0.1);
      borderColor = AppTheme.errorColor;
      textColor = AppTheme.errorColor;
      icon = Icons.cancel;
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryColor.withOpacity(0.1);
      borderColor = AppTheme.primaryColor;
      textColor = AppTheme.primaryColor;
    }

    return Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: isAnswerSubmitted ? null : () => onAnswerSelected(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Option Letter
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected || showCorrectAnswer || showWrongAnswer
                      ? borderColor
                      : AppTheme.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index), // A, B, C, D
                    style: TextStyle(
                      color: isSelected || showCorrectAnswer || showWrongAnswer
                          ? AppTheme.secondaryColor
                          : AppTheme.accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: AppConstants.defaultPadding),
              
              // Option Text
              Expanded(
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
              
              // Status Icon
              if (icon != null)
                Icon(
                  icon,
                  color: textColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
