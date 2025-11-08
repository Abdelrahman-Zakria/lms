import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class TimerWidget extends StatelessWidget {
  final int timeRemaining;
  final bool isActive;

  const TimerWidget({
    super.key,
    required this.timeRemaining,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = timeRemaining ~/ 60;
    final seconds = timeRemaining % 60;
    final timeText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    Color timerColor = AppTheme.primaryColor;
    if (timeRemaining <= 10) {
      timerColor = AppTheme.errorColor;
    } else if (timeRemaining <= 30) {
      timerColor = AppTheme.warningColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      decoration: BoxDecoration(
        color: timerColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: timerColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: timerColor,
            size: 20,
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            timeText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: timerColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}


