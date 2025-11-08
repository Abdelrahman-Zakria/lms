import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class LessonCard extends StatelessWidget {
  final dynamic lesson;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = lesson.progress != null && lesson.progress! > 0;
    // final progressPercentage = lesson.progress != null ? lesson.progress! : 0.0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isCompleted 
              ? AppTheme.successColor.withOpacity(0.3)
              : AppTheme.accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              // Lesson Icon/Image
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isCompleted 
                      ? AppTheme.successColor.withOpacity(0.1)
                      : AppTheme.accentColor.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: lesson.image != null && lesson.image!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: lesson.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppTheme.accentColor.withOpacity(0.1),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            _getLessonIcon(),
                            color: isCompleted 
                                ? AppTheme.successColor
                                : AppTheme.accentColor,
                          ),
                        )
                      : Icon(
                          _getLessonIcon(),
                          color: isCompleted 
                              ? AppTheme.successColor
                              : AppTheme.accentColor,
                        ),
                ),
              ),
              
              const SizedBox(width: AppConstants.defaultPadding),
              
              // Lesson Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title ?? 'Untitled Lesson',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    if (lesson.description != null && lesson.description!.isNotEmpty)
                      Text(
                        lesson.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.accentColor,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                    const SizedBox(height: 8),
                    
                    // Lesson Details Row
                    Row(
                      children: [
                        // Duration
                        if (lesson.duration != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: AppTheme.accentColor,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  lesson.duration!,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppTheme.accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        
                        if (lesson.duration != null) const SizedBox(width: 8),
                        
                        // Difficulty
                        if (lesson.difficulty != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(lesson.difficulty!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              lesson.difficulty!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        
                        const Spacer(),
                        
                        // Status Icon
                        Icon(
                          isCompleted ? Icons.check_circle : Icons.play_circle_outline,
                          color: isCompleted 
                              ? AppTheme.successColor
                              : AppTheme.accentColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLessonIcon() {
    if (lesson.videoUrl != null && lesson.videoUrl!.isNotEmpty) {
      return Icons.play_circle_filled;
    } else if (lesson.audioUrl != null && lesson.audioUrl!.isNotEmpty) {
      return Icons.headphones;
    } else {
      return Icons.book;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppTheme.successColor;
      case 'medium':
        return AppTheme.warningColor;
      case 'hard':
        return AppTheme.errorColor;
      default:
        return AppTheme.accentColor;
    }
  }
}