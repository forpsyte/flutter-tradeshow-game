import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeshow/core/error/exceptions.dart';

import '../models/player_model.dart';
import 'player_local_data_source_interface.dart';

const CACHE_ALL_PLAYERS_LIST = 'CACHE_ALL_PLAYERS_LIST';
const CACHE_TOP_PLAYERS_LIST = 'CACHE_TOP_PLAYERS_LIST';

class PlayerLocalDataSource implements PlayerLocalDataSourceInterface {
  final SharedPreferences sharedPreferences;

  PlayerLocalDataSource({
    @required this.sharedPreferences,
  });

  @override
  Future<void> cacheAllPlayers(List<PlayerModel> players) {
    return _cachePlayers(players, CACHE_ALL_PLAYERS_LIST);
  }

  @override
  Future<void> cacheTopPlayers(List<PlayerModel> players) {
    return _cachePlayers(players, CACHE_TOP_PLAYERS_LIST);
  }

  @override
  Future<List<PlayerModel>> getLastAllPlayers() {
    return _getPlayers(CACHE_ALL_PLAYERS_LIST);
  }

  @override
  Future<List<PlayerModel>> getLastTopPlayers() {
    return _getPlayers(CACHE_TOP_PLAYERS_LIST);
  }

  Future<List<PlayerModel>> _getPlayers(String cacheKey) {
    final players = sharedPreferences.getStringList(cacheKey);
    if (players != null) {
      final result = players
          .map((player) => PlayerModel.fromJson(json.decode(player)))
          .toList();
      return Future.value(result);
    } else {
      throw CacheException();
    }
  }

  Future<void> _cachePlayers(List<PlayerModel> players, String cacheKey) {
    final cache = players.map((player) {
      return json.encode(player.toJson());
    }).toList();
    return sharedPreferences.setStringList(cacheKey, cache);
  }
}
