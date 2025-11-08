import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/question.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../models/question_model.dart';
import '../models/answer_request_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final ApiClient apiClient;

  QuizRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Question>>> getQuestions(String lessonId) async {
    try {
      final response = await apiClient.post(
        AppConstants.questionsEndpoint,
        data: {'lesson_id': lessonId},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final questions = data
            .map((json) => QuestionModel.fromJson(json))
            .map((model) => Question(
                  id: model.id,
                  question: model.question,
                  image: model.image,
                  options: model.options,
                  correctAnswer: model.correctAnswer,
                  explanation: model.explanation,
                  timeLimit: model.timeLimit,
                ))
            .toList();
        
        return Right(questions);
      } else {
        return Left(ServerFailure('Failed to fetch questions'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> submitAnswer({
    required int answerTime,
    required int answerNum,
    required String questionId,
    required bool isLast,
  }) async {
    try {
      final requestModel = AnswerRequestModel(
        answerTime: answerTime,
        answerNum: answerNum,
        questionId: questionId,
        isLast: isLast,
      );

      final response = await apiClient.post(
        AppConstants.answerEndpoint,
        data: requestModel.toJson(),
      );
      
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to submit answer'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
