import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../business/entities/pokemon_entity.dart';
import '../../business/usecases/get_pokemon.dart';
import '../../data/datasources/pokemon_local_data_source.dart';
import '../../data/datasources/pokemon_remote_data_source.dart';
import '../../data/repositories/pokemon_repository_impl.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonEntity? pokemon;
  Failure? failure;

  PokemonProvider({
    this.pokemon,
    this.failure,
  });

  void eitherFailureOrPokemon({
    required String value,
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
        notifyListeners();
      },
    );
  }
}
