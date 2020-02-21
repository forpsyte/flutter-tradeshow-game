import '../../domain/entities/player.dart';
import '../models/player_model.dart';

abstract class PlayerRemoteDataSourceInterface {
  /// Uses the firestore api to retrive all documents.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PlayerModel>> getAllPlayers();

  /// Uses the firestore api to retrive all documents
  /// sorted by a specified field value.
  /// 
  /// Throws a [ServerException] for all error codes.
  Future<List<PlayerModel>> getTopPlayers();

  /// Uses the firestore api to create a document.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<bool> submitPlayerInformation(Player data);
}