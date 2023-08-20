import 'dart:convert';

import 'package:mapp_arch/core/errors/exceptions.dart';
import 'package:mapp_arch/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PokemonImageLocalDataSource {
  Future<void>? cachePokemonImage(PokemonImageModel? pokemonImageToCache);
  Future<PokemonImageModel>? getLastPokemonImage();
}

const cachedPokemonImage = 'CACHED_POKEMON_IMAGE';

class PokemonImageLocalDataSourceImpl implements PokemonImageLocalDataSource {
  final SharedPreferences sharedPreferences;

  PokemonImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<PokemonImageModel>? getLastPokemonImage() {
    final jsonString = sharedPreferences.getString(cachedPokemonImage);

    if (jsonString != null) {
      return Future.value(PokemonImageModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cachePokemonImage(
      PokemonImageModel? pokemonImageToCache) async {
    if (pokemonImageToCache != null) {
      sharedPreferences.setString(
        cachedPokemonImage,
        json.encode(
          pokemonImageToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
