import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    @required String email,
    @required String name,
    @required int score,
  }) : super(email: email, name: name, score: score);

  factory PlayerModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data;
    return PlayerModel(
      email: data['email'],
      name: data['name'],
      score: data['score'],
    );
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      email: json['email'],
      name: json['name'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'score': score,
    };
  }

  @override
  List<Object> get props => [email, name, score];
}