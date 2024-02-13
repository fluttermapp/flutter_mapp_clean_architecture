import 'package:dio/dio.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return PokemonImageModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
