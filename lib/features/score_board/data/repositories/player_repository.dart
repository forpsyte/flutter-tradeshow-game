import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/player_repository_interface.dart';
import '../datasources/player_local_data_source_interface.dart';
import '../datasources/player_remote_data_souce_interface.dart';

typedef Future<List<Player>> _RemoteAllOrTopChooser();
typedef Future<List<Player>> _LocalAllOrTopChooser();
typedef Future<void> _CachePlayers(List<Player> players);

class PlayerRepository implements PlayerRepositoryInterface {
  final PlayerRemoteDataSourceInterface remoteDataSource;
  final PlayerLocalDataSourceInterface localDataSource;
  final NetworkInfoInterface networkInfo;

  PlayerRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failure, List<Player>>> getAllPlayers() async {
    return await _getPlayers(
      () { 
        return remoteDataSource.getAllPlayers(); 
      },
      () {
        return localDataSource.getLastAllPlayers();
      },
      (List<Player> players) {
        return localDataSource.cacheAllPlayers(players);
      },
    );
  }

  @override
  Future<Either<Failure, List<Player>>> getTopPlayers() async {
    return await _getPlayers(
      () { 
        return remoteDataSource.getTopPlayers(); 
      },
      () {
        return localDataSource.getLastTopPlayers();
      },
      (List<Player> players) {
        return localDataSource.cacheTopPlayers(players);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> submitPlayerInformation(Player player) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.submitPlayerInformation(player);
        return Right(true);
      } on ServerException {
        return Left(ServerFailure());
      } on DuplicateException {
        return Left(DuplicateFailure());
      } on PlatformException {
        return Left(PlatformFailure());
      } on MissingPluginException {
        return Left(MissingPluginFailure());
      } on FormatException {
        return Left(InvalidEmailFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<Player>>> _getPlayers(
    _RemoteAllOrTopChooser getAllOrTopPlayers,
    _LocalAllOrTopChooser getLastAllOrTopPlayers,
    _CachePlayers cachePlayers,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final players = await getAllOrTopPlayers();
        cachePlayers(players);
        return Right(players);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final players = await getLastAllOrTopPlayers();
        return Right(players);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}