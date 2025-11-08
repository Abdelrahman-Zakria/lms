import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/lesson.dart';

abstract class LessonsRepository {
  Future<Either<Failure, List<Lesson>>> getLessons(String subjectId);
}


