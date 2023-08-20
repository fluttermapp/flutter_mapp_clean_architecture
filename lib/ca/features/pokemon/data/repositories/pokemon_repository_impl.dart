import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/connection/network_info.dart';
import 'package:mapp_arch/core/errors/exceptions.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon/business/repositories/pokemon_repository.dart';
import 'package:mapp_arch/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:mapp_arch/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:mapp_arch/features/pokemon/data/models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  final PokemonLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonModel>> getPokemon(
      {required PokemonParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteActivity =
            await remoteDataSource.getPokemon(params: params);

        localDataSource.cachePokemon(remoteActivity);

        return Right(remoteActivity);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localActivity = await localDataSource.getLastPokemon();
        return Right(localActivity);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }
}
