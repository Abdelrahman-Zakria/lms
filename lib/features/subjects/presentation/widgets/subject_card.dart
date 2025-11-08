import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;
  final VoidCallback onInfoTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = subject.isSubscribe == true;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: isEnabled 
          ? null 
          : Theme.of(context).colorScheme.surface.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: subject.image != null && subject.image!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: subject.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                            child: Icon(
                              Icons.subject,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : Container(
                          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                          child: Icon(
                            Icons.subject,
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Subject Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Description
                    Text(
                      subject.description ?? 'No description available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Bottom Row
                    Row(
                      children: [
                        // Subscribe Status Badge
                        if (!isEnabled)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Not Subscribed',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Difficulty Badge
                        if (isEnabled && subject.difficulty != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(subject.difficulty!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              subject.difficulty!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        
                        const Spacer(),
                        
                        // Progress Indicator
                        if (isEnabled && subject.progress != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.successColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${((subject.progress ?? 0) * 100).toInt()}%',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.successColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        
                        const SizedBox(width: 8),
                        
                        // Info Button
                        IconButton(
                          onPressed: onInfoTap,
                          icon: Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
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