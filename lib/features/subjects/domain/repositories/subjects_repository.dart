import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/subject.dart';

abstract class SubjectsRepository {
  Future<Either<Failure, List<Subject>>> getSubjects({
    required String childId,
    required String termId,
    String? pathId,
  });
}


