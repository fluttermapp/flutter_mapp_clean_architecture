import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/pokemon_image_entity.dart';
import '../../business/usecases/get_pokemon_image.dart';
import '../../data/datasources/pokemon_image_local_data_source.dart';
import '../../data/datasources/pokemon_image_remote_data_source.dart';
import '../../data/repositories/pokemon_image_repository_impl.dart';

part 'pokemon_image_provider.g.dart';

@riverpod
class PokemonImage extends _$PokemonImage {
  PokemonImageEntity? pokemonImage;
  Failure? failure;

  @override
  ({Failure? failure, PokemonImageEntity? pokemonImage}) build() {
    return (failure: failure, pokemonImage: pokemonImage);
  }

  void eitherFailureOrPokemonImage() async {
    PokemonImageRepositoryImpl repository = PokemonImageRepositoryImpl(
      remoteDataSource: PokemonImageRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: PokemonImageLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    if (pokemonImage != null) {
      final failureOrPokemonImage = await GetPokemonImage(pokemonImageRepository: repository).call(
        pokemonImageParams: PokemonImageParams(path: pokemonImage!.path),
      );
      state = failureOrPokemonImage;
    }
  }
}
