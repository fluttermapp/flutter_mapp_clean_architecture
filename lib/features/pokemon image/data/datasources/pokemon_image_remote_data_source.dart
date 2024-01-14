import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mapp_clean_architecture/core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/pokemon_image_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage(
      {required PokemonImageParams params});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage(
      {required PokemonImageParams params}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    directory.deleteSync(recursive: true);
    final String path = '${directory.path}/${params.name}.png';
    final response = await dio.download(
     params.url,
     path,
    );

    if (response.statusCode == 200) {
      return PokemonImageModel.fromJson(json: {kPath: path});
    } else {
      throw ServerException();
    }
  }
}
