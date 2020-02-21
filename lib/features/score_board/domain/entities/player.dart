import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Player extends Equatable {
  final String email;
  final String name;
  final int score;

  Player({
    @required this.email,
    @required this.name,
    @required this.score,
  });

  @override
  List<Object> get props => [email, name, score];
}