import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradeshow/core/error/exceptions.dart';
import 'package:tradeshow/core/error/failures.dart';
import 'package:tradeshow/core/network/network_info.dart';
import 'package:tradeshow/features/score_board/data/datasources/player_local_data_source_interface.dart';
import 'package:tradeshow/features/score_board/data/datasources/player_remote_data_souce_interface.dart';
import 'package:tradeshow/features/score_board/data/models/player_model.dart';
import 'package:tradeshow/features/score_board/data/repositories/player_repository.dart';

class MockRemoteDataSource extends Mock implements PlayerRemoteDataSourceInterface {}

class MockLocalDataSource extends Mock implements PlayerLocalDataSourceInterface {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PlayerRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PlayerRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAllPlayers', () {
    final testPlayer1 = PlayerModel(
      email: 'test.player1@site.com',
      name: 'John Doe',
      score: 20,
    );

    final testPlayer2 = PlayerModel(
      email: 'test.player2@site.com',
      name: 'Jane Doe',
      score: 47,
    );

    final testPlayer3 = PlayerModel(
      email: 'test.player3@site.com',
      name: 'John Smith',
      score: 38,
    );

    final List<PlayerModel> testPlayerModelList = [
      testPlayer1,
      testPlayer2,
      testPlayer3
    ];
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAllPlayers();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          final result = await repository.getAllPlayers();
          // assert
          verify(mockRemoteDataSource.getAllPlayers());
          expect(result, equals(Right(testPlayerModelList)));
        },
      );

      test(
        'should cache all player data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          await repository.getAllPlayers();
          // assert
          verify(mockRemoteDataSource.getAllPlayers());
          verify(mockLocalDataSource.cacheAllPlayers(testPlayerModelList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllPlayers())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAllPlayers();
          // assert
          verify(mockRemoteDataSource.getAllPlayers());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached player data list when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAllPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          final result = await repository.getAllPlayers();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAllPlayers());
          expect(result, equals(Right(testPlayerModelList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAllPlayers())
              .thenThrow(CacheException());
          // act
          final result = await repository.getAllPlayers();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAllPlayers());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getTopPlayers', () {
    final testPlayer1 = PlayerModel(
      email: 'test.player1@site.com',
      name: 'John Doe',
      score: 20,
    );

    final testPlayer2 = PlayerModel(
      email: 'test.player2@site.com',
      name: 'Jane Doe',
      score: 47,
    );

    final testPlayer3 = PlayerModel(
      email: 'test.player3@site.com',
      name: 'John Smith',
      score: 38,
    );

    final List<PlayerModel> testPlayerModelList = [
      testPlayer1,
      testPlayer2,
      testPlayer3
    ];
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAllPlayers();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTopPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          final result = await repository.getTopPlayers();
          // assert
          verify(mockRemoteDataSource.getTopPlayers());
          expect(result, equals(Right(testPlayerModelList)));
        },
      );

      test(
        'should cache all player data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTopPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          await repository.getTopPlayers();
          // assert
          verify(mockRemoteDataSource.getTopPlayers());
          verify(mockLocalDataSource.cacheTopPlayers(testPlayerModelList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTopPlayers())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopPlayers();
          // assert
          verify(mockRemoteDataSource.getTopPlayers());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached player data list when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTopPlayers())
              .thenAnswer((_) async => testPlayerModelList);
          // act
          final result = await repository.getTopPlayers();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTopPlayers());
          expect(result, equals(Right(testPlayerModelList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTopPlayers())
              .thenThrow(CacheException());
          // act
          final result = await repository.getTopPlayers();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTopPlayers());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('submitPlayerInformation', () {
    final testPlayer = PlayerModel(
      email: 'test.player@site.com',
      name: 'John Doe',
      score: 20,
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.submitPlayerInformation(testPlayer);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return true when call to submit player information is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.submitPlayerInformation(testPlayer))
              .thenAnswer((_) async => true);
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          expect(result, Right(true));
        },
      );

      test(
        'should return ServerFailure when call to submit player information is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.submitPlayerInformation(testPlayer))
              .thenThrow(ServerException());
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          verify(mockRemoteDataSource.submitPlayerInformation(testPlayer));
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return DuplicateFailure when call to submit player information is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.submitPlayerInformation(testPlayer))
              .thenThrow(DuplicateException());
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          verify(mockRemoteDataSource.submitPlayerInformation(testPlayer));
          expect(result, equals(Left(DuplicateFailure())));
        },
      );

      test(
        'should return PlatformFailure when call to submit player information is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.submitPlayerInformation(testPlayer))
              .thenThrow(PlatformException(code: 'test-code'));
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          verify(mockRemoteDataSource.submitPlayerInformation(testPlayer));
          expect(result, equals(Left(PlatformFailure())));
        },
      );

      test(
        'should return MissingPluginFailure when call to submit player information is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.submitPlayerInformation(testPlayer))
              .thenThrow(MissingPluginException());
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          verify(mockRemoteDataSource.submitPlayerInformation(testPlayer));
          expect(result, equals(Left(MissingPluginFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ConnectionFailure when device is offline',
        () async {
          // act
          final result = await repository.submitPlayerInformation(testPlayer);
          // assert
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });
}