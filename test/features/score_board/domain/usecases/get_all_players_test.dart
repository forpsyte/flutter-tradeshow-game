import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradeshow/core/usecases/usecase.dart';
import 'package:tradeshow/features/score_board/domain/entities/player.dart';
import 'package:tradeshow/features/score_board/domain/repositories/player_repository_interface.dart';
import 'package:tradeshow/features/score_board/domain/usecases/get_all_players.dart';

class MockPlayerRepository extends Mock
  implements PlayerRepositoryInterface {}

void main() {
  GetAllPlayers usecase;
  MockPlayerRepository mockPlayerRepository;

  setUp(() {
    mockPlayerRepository = MockPlayerRepository();
    usecase = GetAllPlayers(mockPlayerRepository);
  });

  final testPlayer1 = Player(
     email: 'test.player1@site.com',
     name: 'John Doe',
     score: 20,
  );

  final testPlayer2 = Player(
     email: 'test.player2@site.com',
     name: 'Jane Doe',
     score: 47,
  );

  final testPlayer3 = Player(
     email: 'test.player3@site.com',
     name: 'John Smith',
     score: 38,
  );

  final List<Player> testPlayerList = [
    testPlayer1,
    testPlayer2,
    testPlayer3
  ];

  test(
    'should return a list of all players',
    () async {
      // arrange
      when(mockPlayerRepository.getAllPlayers())
        .thenAnswer((_) async => Right(testPlayerList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(testPlayerList));
      verify(mockPlayerRepository.getAllPlayers());
    },
  );

}