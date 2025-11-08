import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/subject.dart';

class SubjectDetailDialog extends StatelessWidget {
  final List<Subject> subjects;

  const SubjectDetailDialog({
    super.key,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.subject,
                    color: AppTheme.secondaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      subjects.length == 1 
                          ? 'Subject Details' 
                          : 'All Subjects (${subjects.length})',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: subjects.length == 1
                  ? _buildSingleSubjectDetails(context, subjects.first)
                  : _buildAllSubjectsList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleSubjectDetails(BuildContext context, Subject subject) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject Image
          if (subject.image != null && subject.image!.isNotEmpty)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.accentColor.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: subject.image!,
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
                      Icons.subject,
                      size: 60,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
              ),
            ),
          
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Subject Name
          Text(
            subject.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
          ),
          
          const SizedBox(height: 8),
          
          // Description
          if (subject.description != null && subject.description!.isNotEmpty)
            Text(
              subject.description!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.accentColor,
                  ),
            ),
          
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Subject Properties
          _buildPropertyCard(
            context,
            'Subject ID',
            subject.id.toString(),
            Icons.tag,
          ),
          
          if (subject.difficulty != null)
            _buildPropertyCard(
              context,
              'Difficulty',
              subject.difficulty!,
              Icons.trending_up,
            ),
          
          if (subject.status != null)
            _buildPropertyCard(
              context,
              'Status',
              subject.status!,
              Icons.info,
            ),
          
          if (subject.progress != null)
            _buildPropertyCard(
              context,
              'Progress',
              '${(subject.progress! * 100).toInt()}%',
              Icons.track_changes,
            ),
          
          // Metadata
          if (subject.metadata != null && subject.metadata!.isNotEmpty)
            _buildMetadataSection(context, subject.metadata!),
        ],
      ),
    );
  }

  Widget _buildAllSubjectsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.accentColor.withOpacity(0.1),
              child: subject.image != null && subject.image!.isNotEmpty
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: subject.image!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.subject,
                          color: AppTheme.accentColor,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.subject,
                      color: AppTheme.accentColor,
                    ),
            ),
            title: Text(
              subject.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subject.description != null)
                  Text(
                    subject.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (subject.difficulty != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(subject.difficulty!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          subject.difficulty!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (subject.difficulty != null && subject.progress != null)
                      const SizedBox(width: 8),
                    if (subject.progress != null)
                      Text(
                        '${(subject.progress! * 100).toInt()}% Complete',
                        style: TextStyle(
                          color: AppTheme.successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              // Navigate to lessons screen
              Navigator.of(context).pushNamed(
                '/lessons',
                arguments: subject,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.accentColor,
              ),
        ),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.primaryColor,
              ),
        ),
      ),
    );
  }

  Widget _buildMetadataSection(BuildContext context, Map<String, dynamic> metadata) {
    return Card(
      margin: const EdgeInsets.only(top: AppConstants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
            ),
            const SizedBox(height: 8),
            ...metadata.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${entry.key}:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentColor,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            )),
          ],
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
