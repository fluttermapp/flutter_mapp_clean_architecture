import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mapp_clean_architecture/core/constants/constants.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams}) async {
    Directory directory = await getApplicationDocumentsDirectory();
    log('PATH: ${directory.path}');

    final String pathFile = '${directory.path}/${pokemonImageParams.name}.png';

    final response = await dio.download(
      pokemonImageParams.imageUrl,
      pathFile,
    );

    if (response.statusCode == 200) {
      return PokemonImageModel.fromJson(json: {kPath: pathFile});
    } else {
      throw ServerException();
    }
  }
}
