import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tradeshow/core/error/failures.dart';
import 'package:tradeshow/core/util/email_validator.dart';

void main() {
  EmailValidator emailValidator;

  setUp(() {
    emailValidator = EmailValidator();
  });

  group('validate', () {
    test(
      'should return true if the email format is valid',
      () async {
        // arrange
        final email = 'test.user1@site.com';
        // act
        final result = emailValidator.validate(email);
        // assert
        expect(result, Right(true));
      },
    );

    test(
      'should return Failure when the email format in invalid',
      () async {
        // arrange
        final email = 'test@site';
        // act
        final result = emailValidator.validate(email);
        // assert
        expect(result, equals(Left(InvalidEmailFailure())));
      },
    );
  });
}