import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/player.dart';

abstract class PlayerRepositoryInterface {
  Future<Either<Failure, bool>> submitPlayerInformation(Player player);
  Future<Either<Failure, List<Player>>> getAllPlayers();
  Future<Either<Failure, List<Player>>> getTopPlayers();
}