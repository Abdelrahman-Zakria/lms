import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class AnswerOption extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isDisabled;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppTheme.secondaryColor;
    Color borderColor = AppTheme.accentColor;
    Color textColor = AppTheme.primaryColor;

    if (isDisabled) {
      if (isCorrect) {
        backgroundColor = AppTheme.successColor.withOpacity(0.1);
        borderColor = AppTheme.successColor;
        textColor = AppTheme.successColor;
      } else if (isWrong) {
        backgroundColor = AppTheme.errorColor.withOpacity(0.1);
        borderColor = AppTheme.errorColor;
        textColor = AppTheme.errorColor;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryColor.withOpacity(0.1);
      borderColor = AppTheme.primaryColor;
    }

    return Card(
      elevation: isSelected ? AppConstants.cardElevation + 2 : AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: BorderSide(
          color: borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: Row(
            children: [
              // Option Letter
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDisabled && (isCorrect || isWrong) 
                      ? borderColor 
                      : AppTheme.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index), // A, B, C, D
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isDisabled && (isCorrect || isWrong) 
                          ? AppTheme.secondaryColor 
                          : AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
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
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),

              // Status Icon
              if (isDisabled) ...[
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: borderColor,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


