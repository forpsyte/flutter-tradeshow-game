import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart' as validator;
import 'package:tradeshow/core/error/failures.dart';

class EmailValidator {
  Either<Failure, bool> validate(String email) {
    try {
      final isValid = validator.EmailValidator.validate(email);
      if(!isValid) throw FormatException();
      return Right(isValid);
    } on FormatException {
      return Left(InvalidEmailFailure());
    }
    
  }
}