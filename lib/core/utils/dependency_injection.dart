import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_test_service.dart';
import '../network/api_client.dart';
import '../utils/device_info_service.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/home_usecases.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/subjects/data/repositories/subjects_repository_impl.dart';
import '../../features/subjects/domain/repositories/subjects_repository.dart';
import '../../features/subjects/domain/usecases/get_subjects_usecase.dart';
import '../../features/subjects/presentation/providers/subjects_provider.dart';
import '../../features/lessons/data/repositories/lessons_repository_impl.dart';
import '../../features/lessons/domain/repositories/lessons_repository.dart';
import '../../features/lessons/domain/usecases/get_lessons_usecase.dart';
import '../../features/lessons/presentation/providers/lessons_provider.dart';
import '../../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../../features/quiz/domain/repositories/quiz_repository.dart';
import '../../features/quiz/domain/usecases/quiz_usecases.dart';
import '../../features/quiz/presentation/providers/quiz_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core services
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerSingleton<DeviceInfoService>(DeviceInfoService());
  getIt.registerSingleton<ApiTestService>(ApiTestService(
    apiClient: getIt(),
    deviceInfoService: getIt(),
  ));

  // Auth Data Sources
  getIt.registerLazySingleton<AuthLocalDataSourceImpl>(
    () => AuthLocalDataSourceImpl(sharedPreferences: getIt()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSourceImpl>(
    () => AuthRemoteDataSourceImpl(apiClient: getIt()),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      deviceInfoService: getIt(),
      apiClient: getIt(),
    ),
  );

  // Auth Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      repository: getIt(),
      deviceInfoService: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: getIt()),
  );

  // Auth Provider
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      loginUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
      logoutUseCase: getIt(),
    ),
  );

  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiClient: getIt()),
  );

  // Home Use Cases
  getIt.registerLazySingleton<GetEducationSystemsUseCase>(
    () => GetEducationSystemsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetEducationStagesUseCase>(
    () => GetEducationStagesUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetClassroomsUseCase>(
    () => GetClassroomsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetTermsUseCase>(
    () => GetTermsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetPathsUseCase>(
    () => GetPathsUseCase(repository: getIt()),
  );

  // Home Provider
  getIt.registerLazySingleton<HomeProvider>(
    () => HomeProvider(
      getEducationSystemsUseCase: getIt(),
      getEducationStagesUseCase: getIt(),
      getClassroomsUseCase: getIt(),
      getTermsUseCase: getIt(),
      getPathsUseCase: getIt(),
    ),
  );

  // Subjects Repository
  getIt.registerLazySingleton<SubjectsRepository>(
    () => SubjectsRepositoryImpl(apiClient: getIt()),
  );

  // Subjects Use Cases
  getIt.registerLazySingleton<GetSubjectsUseCase>(
    () => GetSubjectsUseCase(repository: getIt()),
  );

  // Subjects Provider
  getIt.registerLazySingleton<SubjectsProvider>(
    () => SubjectsProvider(getSubjectsUseCase: getIt()),
  );

  // Lessons Repository
  getIt.registerLazySingleton<LessonsRepository>(
    () => LessonsRepositoryImpl(apiClient: getIt()),
  );

  // Lessons Use Cases
  getIt.registerLazySingleton<GetLessonsUseCase>(
    () => GetLessonsUseCase(repository: getIt()),
  );

  // Lessons Provider
  getIt.registerLazySingleton<LessonsProvider>(
    () => LessonsProvider(getLessonsUseCase: getIt()),
  );

  // Quiz Repository
  getIt.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(apiClient: getIt()),
  );

  // Quiz Use Cases
  getIt.registerLazySingleton<GetQuestionsUseCase>(
    () => GetQuestionsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<SubmitAnswerUseCase>(
    () => SubmitAnswerUseCase(repository: getIt()),
  );

  // Quiz Provider
  getIt.registerLazySingleton<QuizProvider>(
    () => QuizProvider(
      getQuestionsUseCase: getIt(),
      submitAnswerUseCase: getIt(),
    ),
  );
}
