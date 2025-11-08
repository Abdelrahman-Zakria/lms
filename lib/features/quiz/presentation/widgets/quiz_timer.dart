import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class QuizTimer extends StatelessWidget {
  final int timeRemaining;
  final bool isActive;

  const QuizTimer({
    super.key,
    required this.timeRemaining,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = timeRemaining ~/ 60;
    final seconds = timeRemaining % 60;
    final timeString = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    
    Color timerColor = AppTheme.primaryColor;
    if (timeRemaining <= 30) {
      timerColor = AppTheme.errorColor;
    } else if (timeRemaining <= 60) {
      timerColor = AppTheme.warningColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: timerColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: timerColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            color: timerColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            timeString,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: timerColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
          ),
          if (!isActive) ...[
            const SizedBox(width: 8),
            Text(
              '(Paused)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.accentColor,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}


