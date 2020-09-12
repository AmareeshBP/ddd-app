import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) return Right(input);
  return Left(ValueFailure.exeedingLength(failedValue: input, max: maxLength));
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) return Right(input);
  return Left(ValueFailure.empty(failedValue: input));
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return Left(ValueFailure.multiLine(failedValue: input));
  }
  return Right(input);
}

Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
    KtList<T> input, int maxLength) {
  if (input.size <= maxLength) return Right(input);
  return Left(ValueFailure.exeedingLength(failedValue: input, max: maxLength));
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const String emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) return right(input);
  return left(ValueFailure.invalidEmail(failedValue: input));
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) return right(input);
  return left(ValueFailure.shortPassword(failedValue: input));
}
