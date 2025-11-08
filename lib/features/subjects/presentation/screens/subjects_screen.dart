import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_test_service.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/subjects_provider.dart';
import '../widgets/subject_card.dart';
import '../widgets/subject_detail_dialog.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Test Subjects API when screen loads
      getIt<ApiTestService>().testSubjectsAPI();
      _loadSubjects();
    });
  }

  void _loadSubjects() {
    final authProvider = context.read<AuthProvider>();
    final subjectsProvider = context.read<SubjectsProvider>();
    
    if (authProvider.currentUser != null) {
      subjectsProvider.loadSubjects(
        childId: authProvider.currentUser!.id.toString(),
        termId: authProvider.currentUser!.termId.toString(),
        pathId: authProvider.currentUser!.pathId?.toString(),
      );
    }
  }

  List<dynamic> _getFilteredSubjects(List<dynamic> subjects) {
    if (_searchQuery.isEmpty) return subjects;
    
    return subjects.where((subject) {
      return subject.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             subject.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const AppDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            final localizations = AppLocalizations.of(context);
            return Text(localizations?.subjects ?? 'Subjects');
          },
        ),
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
            onPressed: _loadSubjects,
          ),
        ],
      ),
      body: Consumer<SubjectsProvider>(
        builder: (context, subjectsProvider, child) {
          if (subjectsProvider.isLoading) {
            return const LoadingWidget();
          }

          if (subjectsProvider.errorMessage != null) {
            return custom.ErrorWidget(
              message: subjectsProvider.errorMessage!,
              onRetry: () {
                subjectsProvider.clearError();
                _loadSubjects();
              },
            );
          }

          final subjects = subjectsProvider.subjects;
          final filteredSubjects = _getFilteredSubjects(subjects);

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Consumer<LocaleProvider>(
                  builder: (context, localeProvider, child) {
                    final localizations = AppLocalizations.of(context);
                    return TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: localizations?.searchSubjects ?? 'Search subjects...',
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
              ),

              // Subjects Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                child: Row(
                  children: [
                    Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) {
                        final localizations = AppLocalizations.of(context);
                        return Text(
                          localizations?.subjectsFound(filteredSubjects.length) ?? 
                          '${filteredSubjects.length} subjects found',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        );
                      },
                    ),
                    const Spacer(),
                    if (subjects.isNotEmpty)
                      Consumer<LocaleProvider>(
                        builder: (context, localeProvider, child) {
                          final localizations = AppLocalizations.of(context);
                          return TextButton.icon(
                            onPressed: () {
                              // Show all subjects in a detailed view
                              showDialog(
                                context: context,
                                builder: (context) => SubjectDetailDialog(
                                  subjects: subjects,
                                ),
                              );
                            },
                            icon: const Icon(Icons.list),
                            label: Text(localizations?.viewAllDetails ?? 'View All Details'),
                          );
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Subjects Grid
              Expanded(
                child: filteredSubjects.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppTheme.accentColor.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Consumer<LocaleProvider>(
                              builder: (context, localeProvider, child) {
                                final localizations = AppLocalizations.of(context);
                                return Text(
                                  _searchQuery.isEmpty
                                      ? (localizations?.noSubjectsAvailable ?? 'No subjects available')
                                      : (localizations?.noSubjectsFound(_searchQuery) ?? 
                                         'No subjects found for "$_searchQuery"'),
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
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppConstants.defaultPadding),
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = filteredSubjects[index];
                          final isEnabled = subject.isSubscribe == true;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                            child: Opacity(
                              opacity: isEnabled ? 1.0 : 0.5,
                              child: SubjectCard(
                                subject: subject,
                                onTap: isEnabled
                                    ? () {
                                        // Navigate to lessons screen
                                        Navigator.of(context).pushNamed(
                                          '/lessons',
                                          arguments: subject,
                                        );
                                      }
                                    : () {
                                        // Show message that subject is not subscribed
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'This subject is not available. Please subscribe to access it.',
                                            ),
                                            backgroundColor: Theme.of(context).colorScheme.error,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                onInfoTap: () {
                                  // Show subject details
                                  showDialog(
                                    context: context,
                                    builder: (context) => SubjectDetailDialog(
                                      subjects: [subject],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
