import 'dart:convert';

import 'package:flutter_mapp_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class PokemonImageLocalDataSource {
  Future<void> cachePokemonImage({required PokemonImageModel? pokemonImageToCache});
  Future<PokemonImageModel> getLastPokemonImage();
}

const cachedPokemonImage = 'CACHED_TEMPLATE';

class PokemonImageLocalDataSourceImpl implements PokemonImageLocalDataSource {
  final SharedPreferences sharedPreferences;

  PokemonImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<PokemonImageModel> getLastPokemonImage() {
    final jsonString = sharedPreferences.getString(cachedPokemonImage);

    if (jsonString != null) {
      return Future.value(PokemonImageModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePokemonImage({required PokemonImageModel? pokemonImageToCache}) async {
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
