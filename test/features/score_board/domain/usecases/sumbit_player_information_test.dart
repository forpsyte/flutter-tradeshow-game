import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradeshow/features/score_board/domain/entities/player.dart';
import 'package:tradeshow/features/score_board/domain/repositories/player_repository_interface.dart';
import 'package:tradeshow/features/score_board/domain/usecases/submit_player_information.dart';

class MockPlayerRepository extends Mock
  implements PlayerRepositoryInterface {}

void main() {
  SubmitPlayerInformation usecase;
  MockPlayerRepository mockPlayerRepository;

  setUp(() {
    mockPlayerRepository = MockPlayerRepository();
    usecase = SubmitPlayerInformation(mockPlayerRepository);
  });

  final testPlayer = Player(
    email: 'test.user@site.com',
    name: 'John Doe', 
    score: 1,
  );

  test(
    'should submit the player information using the repository',
    () async {
      // arrange
      when(mockPlayerRepository.submitPlayerInformation(any))
        .thenAnswer((_) async => Right(true));
      // act
      final result = await usecase(Params(player: testPlayer));
      // assert
      expect(result, equals(Right(true)));
      verify(mockPlayerRepository.submitPlayerInformation(testPlayer));
    },
  );
}