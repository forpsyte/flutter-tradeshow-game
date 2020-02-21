part of 'score_board_bloc.dart';

abstract class ScoreBoardState extends Equatable {
  const ScoreBoardState();
}

class Empty extends ScoreBoardState {
  @override
  List<Object> get props => [];
}

class Loading extends ScoreBoardState {
  @override
  List<Object> get props => [];
}

class Loaded extends ScoreBoardState {
  final List<Player> players;

  Loaded({
    @required this.players,
  });

  @override
  List<Object> get props => [players];
}

class Error extends ScoreBoardState {
  final String message;

  Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Submitting extends ScoreBoardState {
  @override
  List<Object> get props => [];
}

class Submitted extends ScoreBoardState {
  @override
  List<Object> get props => [];
}
