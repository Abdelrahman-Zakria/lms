import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/subject.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../models/subject_model.dart';

class SubjectsRepositoryImpl implements SubjectsRepository {
  final ApiClient apiClient;

  SubjectsRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Subject>>> getSubjects({
    required String childId,
    required String termId,
    String? pathId,
  }) async {
    try {
      print('📚 Fetching subjects for child: $childId, term: $termId, path: $pathId');
      
      final data = <String, dynamic>{
        'child_id': childId,
        'term_id': termId,
      };
      
      if (pathId != null) {
        data['path_id'] = pathId;
      }

      print('📤 Subjects request data: $data');

      final response = await apiClient.post(
        AppConstants.subjectsEndpoint,
        data: data,
      );
      
      print('📥 Subjects response: ${response.data}');
      
      if (response.statusCode == 200) {
        final dynamic payload = response.data['data'];
        // API returns a map { required: [...], optional: [...] }
        final List<dynamic> responseList = payload is List
            ? payload
            : payload is Map<String, dynamic>
                ? [
                    ...((payload['required'] as List?) ?? const []),
                    ...((payload['optional'] as List?) ?? const []),
                  ]
                : const [];

        final subjects = responseList
            .map((json) => SubjectModel.fromJson(json))
            .map((model) {
              final String? normalizedImage = (model.image != null && model.image!.isNotEmpty)
                  ? (model.image!.startsWith('http')
                      ? model.image!
                      : '${AppConstants.baseUrl}${model.image!}')
                  : null;

              final double? progressFraction = model.progress != null
                  ? (model.progress! / 100)
                  : null;

              return Subject(
                id: int.tryParse(model.id) ?? 0,
                name: model.name,
                description: model.description,
                image: normalizedImage,
                difficulty: model.difficulty,
                status: model.status,
                progress: progressFraction,
                isSubscribe: model.isSubscribe,
                metadata: model.metadata,
              );
            })
            .toList();
        
        print('✅ Successfully loaded ${subjects.length} subjects');
        return Right(subjects);
      } else {
        print('❌ Failed to load subjects: ${response.data}');
        return Left(ServerFailure('Failed to fetch subjects'));
      }
    } catch (e) {
      print('💥 Error loading subjects: $e');
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
