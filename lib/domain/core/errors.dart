import 'package:ddd_app/domain/core/failures.dart';

class UnExpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnExpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encounterd a value at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
