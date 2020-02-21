import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/player.dart';
import '../repositories/player_repository_interface.dart';

class GetAllPlayers implements UseCase<List<Player>, NoParams> {
  final PlayerRepositoryInterface repository;

  GetAllPlayers(this.repository);
  
  @override
  Future<Either<Failure, List<Player>>> call(
    NoParams params
  ) async {
    return await repository.getAllPlayers();
  }
}