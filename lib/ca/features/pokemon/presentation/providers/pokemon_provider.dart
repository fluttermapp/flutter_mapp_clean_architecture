import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapp_arch/core/connection/network_info.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:mapp_arch/features/pokemon/business/usecases/get_pokemon.dart';
import 'package:mapp_arch/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:mapp_arch/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:mapp_arch/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:mapp_arch/features/pokemon_image/presentation/providers/pokemon_image_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonEntity? pokemon;
  Failure? failure;

  PokemonProvider({
    this.pokemon,
    this.failure,
  });

  void eitherFailureOrPokemon({
    required String value,
    required PokemonImageProvider pokemonImageProvider,
  }) async {
    PokemonRepositoryImpl repository = PokemonRepositoryImpl(
      remoteDataSource: PokemonRemoteDataSourceImpl(dio: Dio()),
      localDataSource: PokemonLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrPokemon = await GetPokemon(repository).call(
      params: PokemonParams(id: value),
    );

    failureOrPokemon.fold(
      (newFailure) {
        pokemon = null;
        failure = newFailure;
        notifyListeners();
      },
      (newPokemon) {
        pokemon = newPokemon;
        failure = null;
        pokemonImageProvider.eitherFailureOrPokemonImage(pokemon: pokemon!);
        notifyListeners();
      },
    );
  }
}
