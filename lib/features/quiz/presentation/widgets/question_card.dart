import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Question $questionNumber of $totalQuestions',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppConstants.defaultPadding),

            // Question Image
            if (question.image != null) ...[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  child: CachedNetworkImage(
                    imageUrl: question.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
            ],

            // Question Text
            Text(
              question.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


