// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_bored_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScoreBoardStore on ScoreBoardStoreBase, Store {
  final _$loadPlayersFutureAtom =
      Atom(name: 'ScoreBoardStoreBase.loadPlayersFuture');

  @override
  ObservableFuture<dynamic> get loadPlayersFuture {
    _$loadPlayersFutureAtom.context.enforceReadPolicy(_$loadPlayersFutureAtom);
    _$loadPlayersFutureAtom.reportObserved();
    return super.loadPlayersFuture;
  }

  @override
  set loadPlayersFuture(ObservableFuture<dynamic> value) {
    _$loadPlayersFutureAtom.context.conditionallyRunInAction(() {
      super.loadPlayersFuture = value;
      _$loadPlayersFutureAtom.reportChanged();
    }, _$loadPlayersFutureAtom, name: '${_$loadPlayersFutureAtom.name}_set');
  }

  final _$failureAtom = Atom(name: 'ScoreBoardStoreBase.failure');

  @override
  Failure get failure {
    _$failureAtom.context.enforceReadPolicy(_$failureAtom);
    _$failureAtom.reportObserved();
    return super.failure;
  }

  @override
  set failure(Failure value) {
    _$failureAtom.context.conditionallyRunInAction(() {
      super.failure = value;
      _$failureAtom.reportChanged();
    }, _$failureAtom, name: '${_$failureAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: 'ScoreBoardStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$successMessageAtom = Atom(name: 'ScoreBoardStoreBase.successMessage');

  @override
  String get successMessage {
    _$successMessageAtom.context.enforceReadPolicy(_$successMessageAtom);
    _$successMessageAtom.reportObserved();
    return super.successMessage;
  }

  @override
  set successMessage(String value) {
    _$successMessageAtom.context.conditionallyRunInAction(() {
      super.successMessage = value;
      _$successMessageAtom.reportChanged();
    }, _$successMessageAtom, name: '${_$successMessageAtom.name}_set');
  }

  final _$submitSuccessAtom = Atom(name: 'ScoreBoardStoreBase.submitSuccess');

  @override
  bool get submitSuccess {
    _$submitSuccessAtom.context.enforceReadPolicy(_$submitSuccessAtom);
    _$submitSuccessAtom.reportObserved();
    return super.submitSuccess;
  }

  @override
  set submitSuccess(bool value) {
    _$submitSuccessAtom.context.conditionallyRunInAction(() {
      super.submitSuccess = value;
      _$submitSuccessAtom.reportChanged();
    }, _$submitSuccessAtom, name: '${_$submitSuccessAtom.name}_set');
  }

  final _$numClicksAtom = Atom(name: 'ScoreBoardStoreBase.numClicks');

  @override
  int get numClicks {
    _$numClicksAtom.context.enforceReadPolicy(_$numClicksAtom);
    _$numClicksAtom.reportObserved();
    return super.numClicks;
  }

  @override
  set numClicks(int value) {
    _$numClicksAtom.context.conditionallyRunInAction(() {
      super.numClicks = value;
      _$numClicksAtom.reportChanged();
    }, _$numClicksAtom, name: '${_$numClicksAtom.name}_set');
  }

  final _$gameOverAtom = Atom(name: 'ScoreBoardStoreBase.gameOver');

  @override
  bool get gameOver {
    _$gameOverAtom.context.enforceReadPolicy(_$gameOverAtom);
    _$gameOverAtom.reportObserved();
    return super.gameOver;
  }

  @override
  set gameOver(bool value) {
    _$gameOverAtom.context.conditionallyRunInAction(() {
      super.gameOver = value;
      _$gameOverAtom.reportChanged();
    }, _$gameOverAtom, name: '${_$gameOverAtom.name}_set');
  }

  final _$_loadInitialPlayersAsyncAction = AsyncAction('_loadInitialPlayers');

  @override
  Future<void> _loadInitialPlayers() {
    return _$_loadInitialPlayersAsyncAction
        .run(() => super._loadInitialPlayers());
  }

  final _$submitAsyncAction = AsyncAction('submit');

  @override
  Future<void> submit({String email, String name, int score}) {
    return _$submitAsyncAction
        .run(() => super.submit(email: email, name: name, score: score));
  }

  final _$ScoreBoardStoreBaseActionController =
      ActionController(name: 'ScoreBoardStoreBase');

  @override
  void loadInitialPlayers() {
    final _$actionInfo = _$ScoreBoardStoreBaseActionController.startAction();
    try {
      return super.loadInitialPlayers();
    } finally {
      _$ScoreBoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementClickCount() {
    final _$actionInfo = _$ScoreBoardStoreBaseActionController.startAction();
    try {
      return super.incrementClickCount();
    } finally {
      _$ScoreBoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetClickCount() {
    final _$actionInfo = _$ScoreBoardStoreBaseActionController.startAction();
    try {
      return super.resetClickCount();
    } finally {
      _$ScoreBoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadPlayersFuture: ${loadPlayersFuture.toString()},failure: ${failure.toString()},errorMessage: ${errorMessage.toString()},successMessage: ${successMessage.toString()},submitSuccess: ${submitSuccess.toString()},numClicks: ${numClicks.toString()},gameOver: ${gameOver.toString()}';
    return '{$string}';
  }
}
