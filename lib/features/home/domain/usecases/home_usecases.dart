import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/education_system.dart';
import '../entities/education_stage.dart';
import '../entities/classroom.dart';
import '../entities/term.dart';
import '../entities/path.dart';
import '../repositories/home_repository.dart';

class GetEducationSystemsUseCase {
  final HomeRepository repository;

  GetEducationSystemsUseCase({required this.repository});

  Future<Either<Failure, List<EducationSystem>>> call() async {
    return await repository.getEducationSystems();
  }
}

class GetEducationStagesUseCase {
  final HomeRepository repository;

  GetEducationStagesUseCase({required this.repository});

  Future<Either<Failure, List<EducationStage>>> call(String systemId) async {
    return await repository.getEducationStages(systemId);
  }
}

class GetClassroomsUseCase {
  final HomeRepository repository;

  GetClassroomsUseCase({required this.repository});

  Future<Either<Failure, List<Classroom>>> call(String stageId) async {
    return await repository.getClassrooms(stageId);
  }
}

class GetTermsUseCase {
  final HomeRepository repository;

  GetTermsUseCase({required this.repository});

  Future<Either<Failure, List<Term>>> call(String classroomId) async {
    return await repository.getTerms(classroomId);
  }
}

class GetPathsUseCase {
  final HomeRepository repository;

  GetPathsUseCase({required this.repository});

  Future<Either<Failure, List<Path>>> call(String classroomId) async {
    return await repository.getPaths(classroomId);
  }
}

