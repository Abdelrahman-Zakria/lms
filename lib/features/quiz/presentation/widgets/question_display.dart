import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/question.dart';

class QuestionDisplay extends StatelessWidget {
  final Question question;

  const QuestionDisplay({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Text
            Text(
              question.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
            ),
            
            // Question Image (if available)
            if (question.image != null && question.image!.isNotEmpty) ...[
              const SizedBox(height: AppConstants.defaultPadding),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.accentColor.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: question.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      child: const Icon(
                        Icons.image,
                        size: 60,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


