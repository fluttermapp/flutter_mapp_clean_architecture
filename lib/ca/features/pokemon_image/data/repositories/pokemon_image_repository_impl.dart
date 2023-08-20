import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/connection/network_info.dart';
import 'package:mapp_arch/core/errors/exceptions.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon_image/business/repositories/pokemon_image_repository.dart';
import 'package:mapp_arch/features/pokemon_image/data/datasources/pokemon_image_local_data_source.dart';
import 'package:mapp_arch/features/pokemon_image/data/datasources/pokemon_image_remote_data_source.dart';
import 'package:mapp_arch/features/pokemon_image/data/models/pokemon_image_model.dart';

class PokemonImageRepositoryImpl implements PokemonImageRepository {
  final PokemonImageRemoteDataSource remoteDataSource;

  final PokemonImageLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  PokemonImageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonImageModel?>> getPokemonImage(
      {required PokemonImageParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final pokemonImage =
            await remoteDataSource.getPokemonImage(params: params);

        localDataSource.cachePokemonImage(pokemonImage);

        return Right(pokemonImage);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localActivity = await localDataSource.getLastPokemonImage();
        return Right(localActivity);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
