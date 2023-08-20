import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/usecases/usecase.dart';
import '../models/pokemon_image_model.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams params});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage({
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
