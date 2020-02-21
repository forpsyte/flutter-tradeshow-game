import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:tradeshow/core/error/exceptions.dart';
import 'package:tradeshow/features/score_board/data/datasources/player_remote_data_source.dart';
import 'package:tradeshow/features/score_board/data/models/player_model.dart';

class MockFirestore extends Mock implements Firestore {}
class MockCollectionReference extends Mock implements CollectionReference {}
class MockQuery extends Mock implements Query {}
class MockQuerySnapshot extends Mock implements QuerySnapshot {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}
class MockDocumentReference extends Mock implements DocumentReference {}
class MockStream<MockQuerySnapshot> extends Mock implements Stream<QuerySnapshot> {}

void main() {
  MockFirestore mockFirestore;
  MockCollectionReference mockCollectionReference;
  MockQuery mockQuery;
  MockQuerySnapshot mockQuerySnapshot;
  MockStream<MockQuerySnapshot> mockStream;
  MockDocumentSnapshot mockDocumentSnapshot1;
  MockDocumentSnapshot mockDocumentSnapshot2;
  MockDocumentSnapshot mockDocumentSnapshot3;
  MockDocumentSnapshot mockDocumentSnapshot4;
  MockDocumentReference mockDocumentReference;
  List<DocumentSnapshot> documents;
  PlayerRemoteDataSource dataSource;
  String collection;

  final testPlayer1 = PlayerModel(
    email: 'test.player1@site.com',
    name: 'John Doe',
    score: 45,
  );

  final testPlayer2 = PlayerModel(
    email: 'test.player2@site.com',
    name: 'Jane Doe',
    score: 24,
  );

  final testPlayer3 = PlayerModel(
    email: 'test.player3@site.com',
    name: 'John Smith',
    score: 28,
  );

  final testPlayer4 = PlayerModel(
    email: 'test.player4@site.com',
    name: 'George Doe',
    score: 82,
  );

  final List<PlayerModel> testPlayerModelList = [
    testPlayer1,
    testPlayer2,
    testPlayer3,
    testPlayer4,
  ];

  final List<PlayerModel> testTopPlayerModelList = [
    testPlayer4,
    testPlayer1,
    testPlayer3,
    testPlayer2,
  ];

  setUp(() {
    mockFirestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockStream = MockStream<MockQuerySnapshot>();
    mockDocumentSnapshot1 = MockDocumentSnapshot();
    mockDocumentSnapshot2 = MockDocumentSnapshot();
    mockDocumentSnapshot3 = MockDocumentSnapshot();
    mockDocumentSnapshot4 = MockDocumentSnapshot();
    mockDocumentReference = MockDocumentReference();
    collection = 'test';
    dataSource = PlayerRemoteDataSource(
      firestore: mockFirestore,
      collection: collection
    );
    documents = [
      mockDocumentSnapshot1,
      mockDocumentSnapshot2,
      mockDocumentSnapshot3,
      mockDocumentSnapshot4,
    ];
  });

  void setupMockDocumentSnapshots() {
    when(mockDocumentSnapshot1.data)
      .thenReturn({
        'email': 'test.player1@site.com',
        'name': 'John Doe',
        'score': 45
      });

    when(mockDocumentSnapshot2.data)
      .thenReturn({
        'email': 'test.player2@site.com',
        'name': 'Jane Doe',
        'score': 24
      });

    when(mockDocumentSnapshot3.data)
      .thenReturn({
        'email': 'test.player3@site.com',
        'name': 'John Smith',
        'score': 28
      });

    when(mockDocumentSnapshot4.data)
      .thenReturn({
        'email': 'test.player4@site.com',
        'name': 'George Doe',
        'score': 82
      });
  }

  void setupMockFirestoreSuccess() {
    when(mockQuerySnapshot.documents)
    .thenReturn(documents);

    when(mockCollectionReference.getDocuments())
    .thenAnswer((_) async => mockQuerySnapshot);

    when(mockFirestore.collection(any))
    .thenReturn(mockCollectionReference);
  }

  void setupMockFirestoreFailure() {
    when(mockCollectionReference.getDocuments())
    .thenThrow(PlatformException(code: 'test-code'));

    when(mockFirestore.collection(any))
    .thenReturn(mockCollectionReference);
  }
  
  group('getAllPlayers', () {
    test(
      'should return a PlayerModel list when call to firestore is successful',
      () async {
        // arrange
        setupMockDocumentSnapshots();
        setupMockFirestoreSuccess();
        // act
        final result = await dataSource.getAllPlayers();
        // assert
        expect(result, equals(testPlayerModelList));
      },
    );

    test(
      'should throw a PlatformException when call to firestore is unsuccessful',
      () async {
        // arrange
        setupMockFirestoreFailure();
        // act
        final call = dataSource.getAllPlayers;
        // assert
        expect(() => call(), throwsA(TypeMatcher<PlatformException>()));
      },
    );
  });

  group('getTopPlayers', () {
    test(
      'should return a sorted PlayerModel list when call to firestore is successful',
      () async {
        // arrange
        setupMockDocumentSnapshots();
        setupMockFirestoreSuccess();
        // act
        final result = await dataSource.getTopPlayers();
        // assert
        expect(result, equals(testTopPlayerModelList));
      },
    );

    test(
      'should throw a PlatformException when call to firestore is unsuccessful',
      () async {
        // arrange
        setupMockFirestoreFailure();
        // act
        final call = dataSource.getTopPlayers;
        // assert
        expect(() => call(), throwsA(TypeMatcher<PlatformException>()));
      },
    );
  });

  group('submitPlayerInformation', () {
    final emptyList = List<DocumentSnapshot>();
    final nonEmptyList = [mockDocumentSnapshot1];

    test(
      'should return true when call to create a document is successful',
      () async {
        // arrange
        when(mockQuerySnapshot.documents)
        .thenReturn(emptyList);

        when(mockStream.first)
        .thenAnswer((_) async => mockQuerySnapshot);

        when(mockQuery.snapshots())
        .thenAnswer((_) => mockStream);

        when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
        .thenReturn(mockQuery);

        when(mockFirestore.collection(any))
        .thenReturn(mockCollectionReference);

        when(mockCollectionReference.document())
        .thenReturn(mockDocumentReference);

        // act
        final result = await dataSource.submitPlayerInformation(testPlayer1);
        // assert
        expect(result, equals(true));
      },
    );

    test(
    'should throw a DuplicateException when a player with a given email exists',
    () async {
      // arrange
      when(mockQuerySnapshot.documents)
      .thenReturn(nonEmptyList);

      when(mockStream.first)
      .thenAnswer((_) async => mockQuerySnapshot);

      when(mockQuery.snapshots())
      .thenAnswer((_) => mockStream);

      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
      .thenReturn(mockQuery);

      when(mockCollectionReference.document())
      .thenReturn(mockDocumentReference);

      when(mockFirestore.collection(any))
      .thenReturn(mockCollectionReference);
      // act
      final call = dataSource.submitPlayerInformation;
      // assert
      expect(() => call(testPlayer1), throwsA(TypeMatcher<DuplicateException>()));
    },
  );
  });
}

