import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: AppTheme.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}


