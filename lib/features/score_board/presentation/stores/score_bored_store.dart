import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/player_model.dart';
import '../../domain/entities/player.dart';
import '../../domain/usecases/get_top_players.dart';
import '../../domain/usecases/submit_player_information.dart';

part 'score_bored_store.g.dart';

class ScoreBoardStore = ScoreBoardStoreBase with _$ScoreBoardStore;

abstract class ScoreBoardStoreBase with Store {
  final GetTopPlayers getTopPlayers;
  final SubmitPlayerInformation submitPlayerInformation;

  ScoreBoardStoreBase({
    @required GetTopPlayers listAction,
    @required SubmitPlayerInformation submitAction,
  })  : assert(listAction != null),
        assert(submitAction != null),
        this.getTopPlayers = listAction,
        this.submitPlayerInformation = submitAction;

  List<Player> collection = List<Player>();

  @observable
  ObservableFuture loadPlayersFuture;

  @observable
  Failure failure;

  @observable
  String errorMessage;

  @observable
  String successMessage;

  @observable
  bool submitSuccess;

  @observable
  int numClicks = 0;

  @observable
  bool gameOver = false;

  @action
  void loadInitialPlayers() {
    
    loadPlayersFuture = ObservableFuture(_loadInitialPlayers());
  }

  @action
  Future<void> _loadInitialPlayers() async {
    collection.clear();
    final result = await getTopPlayers(NoParams());
    result.fold(
      (failure) {
        this.failure = failure;
        errorMessage = 'An error occured when loading the score board';
      },
      (players) {
        collection.addAll(players);
      },
    );
  }

  @action
  void incrementClickCount() {
    numClicks++;
  }

  @action
  void resetClickCount() {
    numClicks = 0;
  }

  @action
  Future<void> submit({
    String email,
    String name,
    int score,
  }) async {
    final player = PlayerModel(
      email: email,
      name: name,
      score: score,
    );

    final result = await submitPlayerInformation(Params(player: player));
    result.fold(
      (failure) {
        this.failure = failure;
        errorMessage = "An error occurred while submitting your score";
        print('error');
      },
      (success) {
        this.submitSuccess = success;
        successMessage = "Your score was submitted successfully";
        print('success');
      },
    );
  }
}
