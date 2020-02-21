import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tradeshow/core/error/failures.dart';
import 'package:tradeshow/core/usecases/usecase.dart';
import 'package:tradeshow/core/util/email_validator.dart';
import 'package:tradeshow/features/score_board/data/models/player_model.dart';
import 'package:tradeshow/features/score_board/domain/usecases/get_top_players.dart';
import 'package:tradeshow/features/score_board/domain/usecases/submit_player_information.dart';
import 'package:tradeshow/features/score_board/presentation/bloc/score_board_bloc.dart';

class MockSubmitPlayerInformation extends Mock
    implements SubmitPlayerInformation {}

class MockGetTopPlayers extends Mock implements GetTopPlayers {}

class MockEmailValidator extends Mock implements EmailValidator {}

void main() {
  ScoreBoardBloc bloc;
  MockSubmitPlayerInformation mockSubmitPlayerInformation;
  MockGetTopPlayers mockGetTopPlayers;
  MockEmailValidator mockEmailValidator;

  setUp(() {
    mockSubmitPlayerInformation = MockSubmitPlayerInformation();
    mockGetTopPlayers = MockGetTopPlayers();
    mockEmailValidator = MockEmailValidator();
    bloc = ScoreBoardBloc(
      submit: mockSubmitPlayerInformation,
      list: mockGetTopPlayers,
      validator: mockEmailValidator,
    );
  });

  test('initial state should be empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });
  
  group('SubmitPlayerInformationEvent', () {
    final email = 'test.user1@site.com';
    final name = 'John Doe';
    final score = 25;
    final tPlayerModel = PlayerModel(email: email, name: name, score: score,);

    test(
      'should call the EmailValidator to validate the string',
      () async {
        // arrange
        when(mockEmailValidator.validate(any))
          .thenReturn(Right(true));
        // act
        bloc.add(SubmitPlayerInformationEvent(email, name, score));
        await untilCalled(mockEmailValidator.validate(any));
        // assert
        verify(mockEmailValidator.validate(email));
      },
    );

    test(
      'should emit [Error] when email is invalid',
      () async {
        // arrange
        when(mockEmailValidator.validate(any))
          .thenReturn(Left(InvalidEmailFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_EMAIL_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(SubmitPlayerInformationEvent(email, name, score));
        await untilCalled(mockEmailValidator.validate(any));
      },
    );

    test(
      'should submit data using the submission use case',
      () async {
        // arrange
        when(mockEmailValidator.validate(any))
          .thenReturn(Right(true));
        when(mockSubmitPlayerInformation(any))
          .thenAnswer((_) async => Right(true));
        // act
        bloc.add(SubmitPlayerInformationEvent(email, name, score));
        await untilCalled(mockSubmitPlayerInformation(any));
        // assert
        verify(mockSubmitPlayerInformation(Params(player: tPlayerModel)));
      },
    );

    test(
      'should emit [Submitting, Submitted] when data is submitted successfully',
      () async {
        // arrange
        when(mockEmailValidator.validate(any))
          .thenReturn(Right(true));
        when(mockSubmitPlayerInformation(any))
          .thenAnswer((_) async => Right(true));
        // assert later
        final expected = [
          Empty(),
          Submitting(),
          Submitted(),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(SubmitPlayerInformationEvent(email, name, score));
        await untilCalled(mockSubmitPlayerInformation(any));
      },
    );

    test(
      'should emit [Submitting, Error] when data submission fails',
      () async {
        // arrange
        when(mockEmailValidator.validate(any))
          .thenReturn(Right(true));
        when(mockSubmitPlayerInformation(any))
          .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Submitting(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(SubmitPlayerInformationEvent(email, name, score));
        await untilCalled(mockSubmitPlayerInformation(any));
      },
    );
  });

  group('GetTopPlayersEvent', () {
    final testPlayer = PlayerModel(email: 'test.user@site.com', name: 'John Doe', score: 25,);
    final testPlayerList = [testPlayer];
    test(
      'should get data from the get top players use case',
      () async {
        // arrange
        when(mockGetTopPlayers(any))
          .thenAnswer((_) async => Right(testPlayerList));
        // act
        bloc.add(GetTopPlayersEvent());
        await untilCalled(mockGetTopPlayers(any));
        // assert
        verify(mockGetTopPlayers(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when call to get top players is successful',
      () async {
        // arrange
        when(mockGetTopPlayers(any))
          .thenAnswer((_) async => Right(testPlayerList));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(players: testPlayerList),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTopPlayersEvent());
        await untilCalled(mockGetTopPlayers(any));
      },
    );

    test(
      'should emit [Loading, Error] when call to get top players fails',
      () async {
        // arrange
        when(mockGetTopPlayers(any))
          .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTopPlayersEvent());
        await untilCalled(mockGetTopPlayers(any));
      },
    );

    test(
      'should emit [Loading, Error] with proper message when call to get top players fails',
      () async {
        // arrange
        when(mockGetTopPlayers(any))
          .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTopPlayersEvent());
        await untilCalled(mockGetTopPlayers(any));
      },
    );
  });

  
}
