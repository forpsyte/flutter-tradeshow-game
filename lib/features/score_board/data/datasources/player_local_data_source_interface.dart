import '../models/player_model.dart';

abstract class PlayerLocalDataSourceInterface {
  /// Gets the cached [PlayerModel] list which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PlayerModel>> getLastAllPlayers();

  /// Gets the cached [PlayerModel] list which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PlayerModel>> getLastTopPlayers();
  
  Future<void> cacheAllPlayers(List<PlayerModel> players);

  Future<void> cacheTopPlayers(List<PlayerModel> players);
}