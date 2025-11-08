import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/question.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Question>>> getQuestions(String lessonId);
  Future<Either<Failure, void>> submitAnswer({
    required int answerTime,
    required int answerNum,
    required String questionId,
    required bool isLast,
  });
}


