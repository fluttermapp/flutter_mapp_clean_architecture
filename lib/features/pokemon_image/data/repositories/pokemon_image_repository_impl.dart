import 'package:flutter_mapp_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/pokemon_image_repository.dart';
import '../datasources/pokemon_image_local_data_source.dart';
import '../datasources/pokemon_image_remote_data_source.dart';

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
  Future<({Failure? failure, PokemonImageModel? pokemonImage})> getPokemonImage(
      {required PokemonImageParams pokemonImageParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        PokemonImageModel remotePokemonImage =
            await remoteDataSource.getPokemonImage(pokemonImageParams: pokemonImageParams);

        localDataSource.cachePokemonImage(pokemonImageToCache: remotePokemonImage);

        return (failure: null, pokemonImage: remotePokemonImage);
      } on ServerException {
        return (failure: ServerFailure(errorMessage: 'This is a server exception'), pokemonImage: null);
      }
    } else {
      try {
        PokemonImageModel localPokemonImage = await localDataSource.getLastPokemonImage();
        return (failure: null, pokemonImage: localPokemonImage);
      } on CacheException {
        return (failure: CacheFailure(errorMessage: 'This is a cache exception'), pokemonImage: null);
      }
    }
  }
}
