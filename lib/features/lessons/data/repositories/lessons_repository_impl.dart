import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/repositories/lessons_repository.dart';
import '../models/lesson_model.dart';

class LessonsRepositoryImpl implements LessonsRepository {
  final ApiClient apiClient;

  LessonsRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Lesson>>> getLessons(String subjectId) async {
    try {
      final response = await apiClient.post(
        AppConstants.lessonsEndpoint,
        data: {'subject_id': subjectId},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final lessons = data
            .map((json) => LessonModel.fromJson(json))
            .map((model) => Lesson(
                  id: int.tryParse(model.id) ?? 0,
                  title: model.title,
                  description: model.description,
                  content: model.content,
                  image: model.image,
                  videoUrl: model.videoUrl,
                  audioUrl: model.audioUrl,
                  duration: model.duration?.toString(),
                  difficulty: model.difficulty,
                  status: model.status,
                  progress: model.progress?.toDouble(),
                  unitId: model.unitId != null ? int.tryParse(model.unitId!) : null,
                  unitName: model.unitName,
                  order: model.order,
                ))
            .toList();
        
        return Right(lessons);
      } else {
        return Left(ServerFailure('Failed to fetch lessons'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
