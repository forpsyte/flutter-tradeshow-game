import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradeshow/features/score_board/data/models/player_model.dart';
import 'package:tradeshow/features/score_board/domain/entities/player.dart';

class MockDocumentSnapshot extends Mock
  implements DocumentSnapshot {}



final tPlayerModel = PlayerModel(
  email: 'test.player@site.com',
  name: 'John Doe',
  score: 1,
);

final tDocumentSnapshotData = {
  'email': 'test.player@site.com',
  'name': 'John Doe',
  'score': 1,
};

void main() {
  MockDocumentSnapshot mockDocumentSnapshot;

  setUp((){
    mockDocumentSnapshot = MockDocumentSnapshot();
  });

  test(
    'should be a subclass of Player entity', 
    () async {
      // assert
      expect(tPlayerModel, isA<Player>());
    }
  );

  test(
    'should return a valid model from a DocumentSnapshot object',
    () async {
      // arrange
      when(mockDocumentSnapshot.data)
        .thenReturn(tDocumentSnapshotData);
      // act
      final result = PlayerModel.fromDocumentSnapshot(mockDocumentSnapshot);
      // assert
      expect(result, tPlayerModel);
      verify(mockDocumentSnapshot.data);
    },
  );
}