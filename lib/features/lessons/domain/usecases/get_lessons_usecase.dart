import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/lesson.dart';
import '../repositories/lessons_repository.dart';

class GetLessonsUseCase {
  final LessonsRepository repository;

  GetLessonsUseCase({required this.repository});

  Future<Either<Failure, List<Lesson>>> call(String subjectId) async {
    return await repository.getLessons(subjectId);
  }
}


