import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../pokemon/business/entities/pokemon_entity.dart';
import '../../business/entities/pokemon_image_entity.dart';
import '../../business/usecases/get_pokemon_image.dart';
import '../../data/datasources/pokemon_image_local_data_source.dart';
import '../../data/datasources/pokemon_image_remote_data_source.dart';
import '../../data/repositories/pokemon_image_repository_impl.dart';

class PokemonImageProvider extends ChangeNotifier {
  PokemonImageEntity? pokemonImage;
  Failure? failure;

  PokemonImageProvider({
    this.pokemonImage,
    this.failure,
  });

  void eitherFailureOrPokemonImage({required PokemonEntity pokemon}) async {
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
    String imagePath = isShiny
        ? pokemon.sprites.other.officialArtwork.frontShiny
        : pokemon.sprites.other.officialArtwork.frontDefault;

    final failureOrPokemonImage = await GetPokemonImage(repository).call(
      params: PokemonImageParams(
        name: pokemon.name,
        imagePath: imagePath,
      ),
    );

    failureOrPokemonImage.fold(
      (newFailure) {
        pokemonImage = null;
        failure = newFailure;
        notifyListeners();
      },
      (newPokemonImage) {
        pokemonImage = newPokemonImage;
        failure = null;
        notifyListeners();
      },
    );
  }
}
