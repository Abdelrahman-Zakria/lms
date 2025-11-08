import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HomeProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const HomeProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = totalSteps == 0 ? 0 : (currentStep + 1) / totalSteps;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step ${currentStep + 1} of $totalSteps',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress.clamp(0, 1),
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          color: Theme.of(context).colorScheme.primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}


