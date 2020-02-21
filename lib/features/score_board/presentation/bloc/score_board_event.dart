part of 'score_board_bloc.dart';

abstract class ScoreBoardEvent extends Equatable {
  const ScoreBoardEvent();
}

class GetTopPlayersEvent extends ScoreBoardEvent {
  @override
  List<Object> get props => [];
}

class SubmitPlayerInformationEvent extends ScoreBoardEvent {
  final String email;
  final String name;
  final int score;

  SubmitPlayerInformationEvent(this.email, this.name, this.score);

  @override
  List<Object> get props => [email, name, score];
}
