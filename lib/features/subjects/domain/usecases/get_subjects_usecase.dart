import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/subject.dart';
import '../repositories/subjects_repository.dart';

class GetSubjectsUseCase {
  final SubjectsRepository repository;

  GetSubjectsUseCase({required this.repository});

  Future<Either<Failure, List<Subject>>> call({
    required String childId,
    required String termId,
    String? pathId,
  }) async {
    return await repository.getSubjects(
      childId: childId,
      termId: termId,
      pathId: pathId,
    );
  }
}


