import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/question.dart';
import '../repositories/quiz_repository.dart';

class GetQuestionsUseCase {
  final QuizRepository repository;

  GetQuestionsUseCase({required this.repository});

  Future<Either<Failure, List<Question>>> call(String lessonId) async {
    return await repository.getQuestions(lessonId);
  }
}

class SubmitAnswerUseCase {
  final QuizRepository repository;

  SubmitAnswerUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required int answerTime,
    required int answerNum,
    required String questionId,
    required bool isLast,
  }) async {
    return await repository.submitAnswer(
      answerTime: answerTime,
      answerNum: answerNum,
      questionId: questionId,
      isLast: isLast,
    );
  }
}


