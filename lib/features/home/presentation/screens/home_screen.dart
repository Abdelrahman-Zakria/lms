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
import '../providers/home_provider.dart';
import '../widgets/selection_card.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Test all navigation APIs when home screen loads
      getIt<ApiTestService>().runAllTests();
      context.read<HomeProvider>().loadEducationSystems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            final localizations = AppLocalizations.of(context);
            return Text(localizations?.educationalSelection ?? 'Educational Selection');
          },
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.isLoading && homeProvider.currentStep == 0) {
            return const LoadingWidget();
          }

          if (homeProvider.errorMessage != null) {
            return custom.ErrorWidget(
              message: homeProvider.errorMessage!,
              onRetry: () {
                homeProvider.clearError();
                if (homeProvider.currentStep == 0) {
                  homeProvider.loadEducationSystems();
                }
              },
            );
          }

          return Column(
            children: [
              // Progress Indicator
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: HomeProgressIndicator(
                  currentStep: homeProvider.currentStep,
                  totalSteps: 5,
                ),
              ),

              // Content
              Expanded(
                child: _buildCurrentStepContent(homeProvider),
              ),

              // Navigation Buttons
              if (homeProvider.currentStep > 0)
                Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: homeProvider.goBack,
                          child: Consumer<LocaleProvider>(
                            builder: (context, localeProvider, child) {
                              final localizations = AppLocalizations.of(context);
                              return Text(localizations?.back ?? 'Back');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: AppConstants.defaultPadding),
                      if (homeProvider.canProceedToSubjects)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to subjects screen
                              Navigator.of(context).pushNamed('/subjects');
                            },
                            child: Consumer<LocaleProvider>(
                              builder: (context, localeProvider, child) {
                                final localizations = AppLocalizations.of(context);
                                return Text(localizations?.continueToSubjects ?? 'Continue to Subjects');
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCurrentStepContent(HomeProvider homeProvider) {
    switch (homeProvider.currentStep) {
      case 0:
        return _buildEducationSystemsStep(homeProvider);
      case 1:
        return _buildEducationStagesStep(homeProvider);
      case 2:
        return _buildClassroomsStep(homeProvider);
      case 3:
        return _buildTermsStep(homeProvider);
      case 4:
        return _buildPathsStep(homeProvider);
      default:
        return Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            final localizations = AppLocalizations.of(context);
            return Center(
              child: Text(localizations?.unknownStep ?? 'Unknown step'),
            );
          },
        );
    }
  }

  Widget _buildEducationSystemsStep(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              final localizations = AppLocalizations.of(context);
              return Text(
                localizations?.selectEducationSystem ?? 'Select Education System',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeProvider.educationSystems.length,
              itemBuilder: (context, index) {
                final system = homeProvider.educationSystems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                  child: SelectionCard(
                    title: system.name,
                    subtitle: system.description,
                    image: system.image,
                    isSelected: homeProvider.selectedSystem?.id == system.id,
                    onTap: () => homeProvider.selectSystem(system),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationStagesStep(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              final localizations = AppLocalizations.of(context);
              return Text(
                localizations?.selectEducationalStage ?? 'Select Educational Stage',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeProvider.educationStages.length,
              itemBuilder: (context, index) {
                final stage = homeProvider.educationStages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                  child: SelectionCard(
                    title: stage.name,
                    subtitle: stage.description,
                    image: stage.image,
                    isSelected: homeProvider.selectedStage?.id == stage.id,
                    onTap: () => homeProvider.selectStage(stage),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassroomsStep(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              final localizations = AppLocalizations.of(context);
              return Text(
                localizations?.selectClassroomGrade ?? 'Select Classroom/Grade',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeProvider.classrooms.length,
              itemBuilder: (context, index) {
                final classroom = homeProvider.classrooms[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                  child: SelectionCard(
                    title: classroom.name,
                    subtitle: classroom.description,
                    image: classroom.image,
                    isSelected: homeProvider.selectedClassroom?.id == classroom.id,
                    onTap: () => homeProvider.selectClassroom(classroom),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsStep(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              final localizations = AppLocalizations.of(context);
              return Text(
                localizations?.selectAcademicTerm ?? 'Select Academic Term',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeProvider.terms.length,
              itemBuilder: (context, index) {
                final term = homeProvider.terms[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                  child: SelectionCard(
                    title: term.name,
                    subtitle: term.description,
                    image: term.image,
                    isSelected: homeProvider.selectedTerm?.id == term.id,
                    onTap: () => homeProvider.selectTerm(term),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathsStep(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              final localizations = AppLocalizations.of(context);
              return Text(
                localizations?.selectEducationalTrack ?? 'Select Educational Track',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeProvider.paths.length,
              itemBuilder: (context, index) {
                final path = homeProvider.paths[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                  child: SelectionCard(
                    title: path.name,
                    subtitle: path.description,
                    image: path.image,
                    isSelected: homeProvider.selectedPath?.id == path.id,
                    onTap: () => homeProvider.selectPath(path),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
