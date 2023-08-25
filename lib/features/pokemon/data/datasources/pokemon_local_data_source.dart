import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exceptions.dart';
import '../models/pokemon_model.dart';


abstract class PokemonLocalDataSource {
  Future<void>? cachePokemon(PokemonModel? pokemonToCache);

  Future<PokemonModel> getLastPokemon();
}

const cachedPokemon = 'CACHED_POKEMON';

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PokemonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<PokemonModel> getLastPokemon() {
    final jsonString = sharedPreferences.getString(cachedPokemon);

    if (jsonString != null) {
      return Future.value(PokemonModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cachePokemon(PokemonModel? pokemonToCache) async {
    
    if (pokemonToCache != null) {
      sharedPreferences.setString(
        cachedPokemon,
        json.encode(
          pokemonToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
