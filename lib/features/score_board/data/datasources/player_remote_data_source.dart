import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart' as validator;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/player.dart';
import '../models/player_model.dart';
import 'player_remote_data_souce_interface.dart';

class PlayerRemoteDataSource implements PlayerRemoteDataSourceInterface {
  final Firestore firestore;
  final String collection;

  PlayerRemoteDataSource({
    @required this.firestore,
    @required this.collection,
  });

  @override
  Future<List<PlayerModel>> getAllPlayers() async {
    try {
      final querySnapshot = await firestore
      .collection(collection)
      .getDocuments();

      return querySnapshot.documents.map((document) {
        return PlayerModel.fromDocumentSnapshot(document);
      }).toList();
    } catch(e) {
      throw e;
    }
    
  }

  @override
  Future<List<PlayerModel>> getTopPlayers() async {
    try {
      final querySnapshot = await firestore
      .collection(collection)
      .getDocuments();

      final players = querySnapshot.documents.map((document) {
        return PlayerModel.fromDocumentSnapshot(document);
      }).toList();

      players.sort((player1, player2) => player2.score - player1.score);
      return players;
    } catch(e) {
      throw e;
    }  
  }

  @override
  Future<bool> submitPlayerInformation(Player data) async {
    try {
      if (!validator.EmailValidator.validate(data.email)) {
        throw FormatException("Invalid email");
      }
      
      final querySnapshot = await firestore
        .collection(collection)
        .where("email", isEqualTo: data.email)
        .snapshots().first;

      final documents = querySnapshot.documents;
      
      if (documents.length > 0) {
        throw DuplicateException();
      }

      await firestore.collection(collection).document()
        .setData({
          'email': data.email,
          'name': data.name,
          'score': data.score
        });
      return true;
    } catch(e) {
      throw e;
    }
  }
}