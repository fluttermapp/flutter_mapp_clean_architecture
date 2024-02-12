import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../business/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_data_source.dart';
import '../datasources/pokemon_remote_data_source.dart';
import '../models/pokemon_model.dart';

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
  Future<({Failure? failure, PokemonModel? pokemon})> getPokemon({required PokemonParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remotePokemon = await remoteDataSource.getPokemon(params: params);

        localDataSource.cachePokemon(remotePokemon);

        return (
          failure: null,
          pokemon: remotePokemon,
        );
      } on ServerException {
        return (
          failure: ServerFailure(errorMessage: 'This is a server exception'),
          pokemon: null,
        );
      }
    } else {
      try {
        final localPokemon = await localDataSource.getLastPokemon();
        return (
          failure: null,
          pokemon: localPokemon,
        );
      } on CacheException {
        return (
          failure: CacheFailure(errorMessage: 'No local data found'),
          pokemon: null,
        );
      }
    }
  }
}
