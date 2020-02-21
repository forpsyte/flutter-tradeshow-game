import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/email_validator.dart';
import '../../data/models/player_model.dart';
import '../../domain/entities/player.dart';
import '../../domain/usecases/get_top_players.dart';
import '../../domain/usecases/submit_player_information.dart';

part 'score_board_event.dart';
part 'score_board_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_EMAIL_FAILURE_MESSAGE = 'Invalid email address';

class ScoreBoardBloc extends Bloc<ScoreBoardEvent, ScoreBoardState> {
  final SubmitPlayerInformation submitPlayerInformation;
  final GetTopPlayers getTopPlayers;
  final EmailValidator emailValidator;

  ScoreBoardBloc({
    @required submit,
    @required list,
    @required validator,
  })  : assert(submit != null),
        assert(list != null),
        assert(validator != null),
        this.submitPlayerInformation = submit,
        this.getTopPlayers = list,
        this.emailValidator = validator;

  @override
  ScoreBoardState get initialState => Empty();

  @override
  Stream<ScoreBoardState> mapEventToState(
    ScoreBoardEvent event,
  ) async* {
    if (event is SubmitPlayerInformationEvent) {
      final isValidEither = emailValidator.validate(event.email);

      yield* isValidEither.fold(
        (failure) async* {
          yield Error(message: INVALID_EMAIL_FAILURE_MESSAGE);
        },
        (success) async* {
          yield Submitting();
          final playerModel = PlayerModel(
            email: event.email,
            name: event.name,
            score: event.score,
          );
          final failureOrBool =
              await submitPlayerInformation(Params(player: playerModel));
          yield failureOrBool.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (success) => Submitted(),
          );
        },
      );
    } else if (event is GetTopPlayersEvent) {
      yield Loading();
      final failureOrList = await getTopPlayers(NoParams());
      yield failureOrList.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (players) => Loaded(players: players),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
