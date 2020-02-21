import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import 'core/network/network_info.dart';
import 'core/util/email_validator.dart';
import 'features/score_board/data/datasources/player_local_data_source.dart';
import 'features/score_board/data/datasources/player_local_data_source_interface.dart';
import 'features/score_board/data/datasources/player_remote_data_souce_interface.dart';
import 'features/score_board/data/datasources/player_remote_data_source.dart';
import 'features/score_board/data/repositories/player_repository.dart';
import 'features/score_board/domain/repositories/player_repository_interface.dart';
import 'features/score_board/domain/usecases/get_top_players.dart';
import 'features/score_board/domain/usecases/submit_player_information.dart';
import 'features/score_board/presentation/stores/score_bored_store.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Score Board
  // Stores
  sl.registerFactory(
    () => ScoreBoardStore(
      listAction: sl(),
      submitAction: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopPlayers(sl()));
  sl.registerLazySingleton(() => SubmitPlayerInformation(sl()));

  // Repository
  sl.registerLazySingleton<PlayerRepositoryInterface>(
    () => PlayerRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PlayerLocalDataSourceInterface>(
    () => PlayerLocalDataSource(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<PlayerRemoteDataSourceInterface>(
    () => PlayerRemoteDataSource(
      firestore: sl(),
      collection: 'players',
    ),
  );

  //! Core
  sl.registerLazySingleton(() => EmailValidator());
  sl.registerLazySingleton<NetworkInfoInterface>(() => NetworkInfoWeb());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final firestore = Firestore.instance;
  final asyncMemoizer = AsyncMemoizer();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => firestore);
  sl.registerFactory(() => asyncMemoizer);
}
