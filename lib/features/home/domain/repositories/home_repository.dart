import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/education_system.dart';
import '../entities/education_stage.dart';
import '../entities/classroom.dart';
import '../entities/term.dart';
import '../entities/path.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<EducationSystem>>> getEducationSystems();
  Future<Either<Failure, List<EducationStage>>> getEducationStages(String systemId);
  Future<Either<Failure, List<Classroom>>> getClassrooms(String stageId);
  Future<Either<Failure, List<Term>>> getTerms(String classroomId);
  Future<Either<Failure, List<Path>>> getPaths(String classroomId);
}

