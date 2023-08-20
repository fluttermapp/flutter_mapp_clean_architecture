import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mapp_arch/core/constants/constants.dart';
import 'package:mapp_arch/core/errors/exceptions.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel>? getPokemonImage({required PokemonImageParams params});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel>? getPokemonImage({
    required PokemonImageParams params,
  }) async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory.deleteSync(recursive: true);
    final String pathFile = '${directory.path}/${params.name}.png';
    final responsePath = await dio.download(
      params.imagePath,
      pathFile,
    );
    if (responsePath.statusCode == 200) {
      return PokemonImageModel.fromJson({kPath: pathFile});
    } else {
      throw ServerException();
    }
  }
}
