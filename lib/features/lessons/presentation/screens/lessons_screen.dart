import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_test_service.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/lessons_provider.dart';
import '../widgets/unit_expansion_tile.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../../../subjects/domain/entities/subject.dart';

class LessonsScreen extends StatefulWidget {
  final Subject subject;

  const LessonsScreen({
    super.key,
    required this.subject,
  });

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showCompletedOnly = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Test Lessons API when screen loads
      getIt<ApiTestService>().testLessonsAPI();
      _loadLessons();
    });
  }

  void _loadLessons() {
    final lessonsProvider = context.read<LessonsProvider>();
    lessonsProvider.loadLessons(widget.subject.id.toString());
  }

  List<dynamic> _getFilteredLessons(List<dynamic> lessons) {
    List<dynamic> filtered = lessons;
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((lesson) {
        return lesson.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               lesson.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    if (_showCompletedOnly) {
      filtered = filtered.where((lesson) {
        return lesson.progress != null && lesson.progress! > 0;
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const AppDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.subject.name),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: _loadLessons,
          ),
        ],
      ),
      body: Column(
        children: [
          // Subject Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.accentColor.withOpacity(0.1),
                ],
              ),
            ),
            child: Row(
              children: [
                // Subject Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.accentColor.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.subject.image != null && widget.subject.image!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.subject.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.subject,
                              color: AppTheme.accentColor,
                            ),
                          )
                        : const Icon(
                            Icons.subject,
                            color: AppTheme.accentColor,
                          ),
                  ),
                ),
                
                const SizedBox(width: AppConstants.defaultPadding),
                
                // Subject Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subject.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                      ),
                      if (widget.subject.description != null)
                        Text(
                          widget.subject.description!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.accentColor,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                // Search Bar
                Consumer<LocaleProvider>(
                  builder: (context, localeProvider, child) {
                    final localizations = AppLocalizations.of(context);
                    return TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: localizations?.searchLessons ?? 'Search lessons...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    );
                  },
                ),
                
                const SizedBox(height: 8),
                
                // Filter Options
                Row(
                  children: [
                    Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) {
                        final localizations = AppLocalizations.of(context);
                        return FilterChip(
                          label: Text(localizations?.completedOnly ?? 'Completed Only'),
                          selected: _showCompletedOnly,
                          onSelected: (selected) {
                            setState(() {
                              _showCompletedOnly = selected;
                            });
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    Consumer2<LessonsProvider, LocaleProvider>(
                      builder: (context, lessonsProvider, localeProvider, child) {
                        final totalLessons = lessonsProvider.lessons.length;
                        final completedLessons = lessonsProvider.lessons
                            .where((lesson) => lesson.progress != null && lesson.progress! > 0)
                            .length;
                        final localizations = AppLocalizations.of(context);
                        
                        return Text(
                          localizations?.completed(completedLessons, totalLessons) ?? 
                          '$completedLessons/$totalLessons completed',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.accentColor,
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Lessons Content
          Expanded(
            child: Consumer<LessonsProvider>(
              builder: (context, lessonsProvider, child) {
                if (lessonsProvider.isLoading) {
                  return const LoadingWidget();
                }

                if (lessonsProvider.errorMessage != null) {
                  return custom.ErrorWidget(
                    message: lessonsProvider.errorMessage!,
                    onRetry: () {
                      lessonsProvider.clearError();
                      _loadLessons();
                    },
                  );
                }

                final lessons = lessonsProvider.lessons;
                final filteredLessons = _getFilteredLessons(lessons);

                if (filteredLessons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isEmpty ? Icons.book_outlined : Icons.search_off,
                          size: 64,
                          color: AppTheme.accentColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Consumer<LocaleProvider>(
                          builder: (context, localeProvider, child) {
                            final localizations = AppLocalizations.of(context);
                            return Text(
                              _searchQuery.isEmpty
                                  ? (localizations?.noLessonsAvailable ?? 'No lessons available')
                                  : (localizations?.noLessonsFound(_searchQuery) ?? 
                                     'No lessons found for "$_searchQuery"'),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppTheme.accentColor,
                                  ),
                            );
                          },
                        ),
                        if (_searchQuery.isNotEmpty)
                          Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return TextButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                                child: Text(localizations?.clearSearch ?? 'Clear Search'),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                }

                // Group lessons by units
                final localizations = AppLocalizations.of(context);
                final lessonsByUnit = <String, List<dynamic>>{};
                for (final lesson in filteredLessons) {
                  final unitName = lesson.unitName ?? (localizations?.general ?? 'General');
                  if (!lessonsByUnit.containsKey(unitName)) {
                    lessonsByUnit[unitName] = [];
                  }
                  lessonsByUnit[unitName]!.add(lesson);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                  ),
                  itemCount: lessonsByUnit.length,
                  itemBuilder: (context, index) {
                    final unitName = lessonsByUnit.keys.elementAt(index);
                    final unitLessons = lessonsByUnit[unitName]!;
                    
                    return UnitExpansionTile(
                      unitName: unitName,
                      lessons: unitLessons,
                      onLessonTap: (lesson) {
                        // Navigate to quiz screen
                        Navigator.of(context).pushNamed(
                          '/quiz',
                          arguments: lesson,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
