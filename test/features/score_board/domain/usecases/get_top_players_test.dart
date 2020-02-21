import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradeshow/core/usecases/usecase.dart';
import 'package:tradeshow/features/score_board/domain/entities/player.dart';
import 'package:tradeshow/features/score_board/domain/repositories/player_repository_interface.dart';
import 'package:tradeshow/features/score_board/domain/usecases/get_top_players.dart';

class MockPlayerRepository extends Mock
  implements PlayerRepositoryInterface {}

void main() {
  GetTopPlayers usecase;
  MockPlayerRepository mockPlayerRepository;

  setUp(() {
    mockPlayerRepository = MockPlayerRepository();
    usecase = GetTopPlayers(mockPlayerRepository);
  });

  final testPlayer1 = Player(
     email: 'test.player1@site.com',
     name: 'John Doe',
     score: 50,
  );

  final testPlayer2 = Player(
     email: 'test.player2@site.com',
     name: 'Jane Doe',
     score: 44,
  );

  final testPlayer3 = Player(
     email: 'test.player3@site.com',
     name: 'John Smith',
     score: 22,
  );

  final List<Player> testPlayerList = [
    testPlayer1,
    testPlayer2,
    testPlayer3
  ];

  test(
    'should return a list of top players',
    () async {
      // arrange
      when(mockPlayerRepository.getTopPlayers())
        .thenAnswer((_) async => Right(testPlayerList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(testPlayerList));
      verify(mockPlayerRepository.getTopPlayers());
    },
  );

}