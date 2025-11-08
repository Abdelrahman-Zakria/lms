import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import 'lesson_card.dart';

class UnitExpansionTile extends StatelessWidget {
  final String unitName;
  final List<dynamic> lessons;
  final Function(dynamic) onLessonTap;

  const UnitExpansionTile({
    super.key,
    required this.unitName,
    required this.lessons,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    final completedLessons = lessons.where((lesson) => 
        lesson.progress != null && lesson.progress! > 0).length;
    final totalLessons = lessons.length;
    final progressPercentage = totalLessons > 0 ? completedLessons / totalLessons : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: Text(
            unitName[0].toUpperCase(),
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          unitName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$totalLessons lessons',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.accentColor,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progressPercentage,
                    backgroundColor: AppTheme.accentColor.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.successColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(progressPercentage * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: lessons.map((lesson) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LessonCard(
                  lesson: lesson,
                  onTap: () => onLessonTap(lesson),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}