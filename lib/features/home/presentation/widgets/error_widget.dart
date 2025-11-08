import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.largePadding),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}


