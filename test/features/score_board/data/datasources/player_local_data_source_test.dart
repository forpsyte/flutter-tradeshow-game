import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeshow/core/error/exceptions.dart';
import 'package:tradeshow/features/score_board/data/datasources/player_local_data_source.dart';
import 'package:tradeshow/features/score_board/data/models/player_model.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  PlayerLocalDataSource dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        PlayerLocalDataSource(sharedPreferences: mockSharedPreferences);
  });

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

  final List<String> cachedPlayerList = [
    fixture('players/player1.json'),
    fixture('players/player2.json'),
    fixture('players/player3.json'),
    fixture('players/player4.json'),
  ];

  group('getLastAllPlayers', () {
    test(
      'should return List<PlayerModel> when there is a string list in cache',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any))
            .thenReturn(cachedPlayerList);
        // act
        final result = await dataSource.getLastAllPlayers();
        // assert
        verify(mockSharedPreferences.getStringList(CACHE_ALL_PLAYERS_LIST));
        expect(result, testPlayerModelList);
      },
    );

    test(
      'should throw CacheException when there is not a cached string list value',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);
        // act
        final call = dataSource.getLastAllPlayers;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('getLastTopPlayers', () {
    test(
      'should return List<PlayerModel> when there is a string list in cache',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any))
            .thenReturn(cachedPlayerList);
        // act
        final result = await dataSource.getLastTopPlayers();
        // assert
        verify(mockSharedPreferences.getStringList(CACHE_TOP_PLAYERS_LIST));
        expect(result, testPlayerModelList);
      },
    );

    test(
      'should throw CacheException when there is not a cached string list value',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);
        // act
        final call = dataSource.getLastTopPlayers;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheAllPlayers', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheAllPlayers(testPlayerModelList);
        // assert
        final expectStringList = testPlayerModelList.map((player) {
          return json.encode(player.toJson());
        }).toList();
        verify(mockSharedPreferences.setStringList(
          CACHE_ALL_PLAYERS_LIST,
          expectStringList
        ));
      },
    );
  });

  group('cacheTopPlayers', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheTopPlayers(testPlayerModelList);
        // assert
        final expectStringList = testPlayerModelList.map((player) {
          return json.encode(player.toJson());
        }).toList();
        verify(mockSharedPreferences.setStringList(
          CACHE_TOP_PLAYERS_LIST,
          expectStringList
        ));
      },
    );
  });
}
