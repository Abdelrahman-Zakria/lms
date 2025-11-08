import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? image;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        elevation: isSelected ? 6 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Image/Icon Section
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: image != null && image!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.school,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.school,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                const SizedBox(width: 16),
                // Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Selection Indicator
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


