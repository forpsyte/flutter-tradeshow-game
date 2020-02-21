import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/player.dart';
import '../repositories/player_repository_interface.dart';

class SubmitPlayerInformation implements UseCase<bool, Params> {
  final PlayerRepositoryInterface repository;

  SubmitPlayerInformation(this.repository);

  Future<Either<Failure, bool>> call(
    Params params
  ) async {
    return await repository.submitPlayerInformation(params.player);
  }
}

class Params extends Equatable {
  final Player player;

  Params({@required this.player});

  @override
  List<Object> get props => [player];
}