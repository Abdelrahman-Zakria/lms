import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/education_system.dart';
import '../../domain/entities/education_stage.dart';
import '../../domain/entities/classroom.dart';
import '../../domain/entities/term.dart';
import '../../domain/entities/path.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/education_system_model.dart';
import '../models/education_stage_model.dart';
import '../models/classroom_model.dart';
import '../models/term_model.dart';
import '../models/path_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<EducationSystem>>> getEducationSystems() async {
    try {
      print('🏫 Fetching education systems...');
      
      final response = await apiClient.post(AppConstants.educationSystemsEndpoint);
      
      log('📥 Education systems response: ${response.data}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final systems = data
            .map((json) => EducationSystemModel.fromJson(json))
            .map((model) => EducationSystem(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                  image: model.image,
                ))
            .toList();
        
        print('✅ Successfully loaded ${systems.length} education systems');
        return Right(systems);
      } else {
        print('❌ Failed to load education systems: ${response.data}');
        return Left(ServerFailure('Failed to fetch education systems'));
      }
    } catch (e) {
      print('💥 Error loading education systems: $e');
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<EducationStage>>> getEducationStages(String systemId) async {
    try {
      print('🎓 Fetching education stages for system: $systemId');
      
      final response = await apiClient.post(
        AppConstants.educationStagesEndpoint,
        data: {'system_id': systemId},
      );
      
      print('📥 Education stages response: ${response.data}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final stages = data
            .map((json) => EducationStageModel.fromJson(json))
            .map((model) => EducationStage(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                  image: model.image,
                  systemId: model.systemId,
                ))
            .toList();
        
        print('✅ Successfully loaded ${stages.length} education stages');
        return Right(stages);
      } else {
        print('❌ Failed to load education stages: ${response.data}');
        return Left(ServerFailure('Failed to fetch education stages'));
      }
    } catch (e) {
      print('💥 Error loading education stages: $e');
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Classroom>>> getClassrooms(String stageId) async {
    try {
      final response = await apiClient.post(
        AppConstants.classroomsEndpoint,
        data: {'stage_id': stageId},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final classrooms = data
            .map((json) => ClassroomModel.fromJson(json))
            .map((model) => Classroom(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                  image: model.image,
                  stageId: model.stageId,
                ))
            .toList();
        
        return Right(classrooms);
      } else {
        return Left(ServerFailure('Failed to fetch classrooms'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Term>>> getTerms(String classroomId) async {
    try {
      final response = await apiClient.post(
        AppConstants.termsEndpoint,
        data: {'classroom_id': classroomId},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final terms = data
            .map((json) => TermModel.fromJson(json))
            .map((model) => Term(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                  image: model.image,
                  classroomId: model.classroomId,
                ))
            .toList();
        
        return Right(terms);
      } else {
        return Left(ServerFailure('Failed to fetch terms'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Path>>> getPaths(String classroomId) async {
    try {
      final response = await apiClient.post(
        AppConstants.pathsEndpoint,
        data: {'classroom_id': classroomId},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final paths = data
            .map((json) => PathModel.fromJson(json))
            .map((model) => Path(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                  image: model.image,
                  classroomId: model.classroomId,
                ))
            .toList();
        
        return Right(paths);
      } else {
        return Left(ServerFailure('Failed to fetch paths'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
