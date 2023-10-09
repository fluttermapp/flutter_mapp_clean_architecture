import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mapp_clean_architecture/core/constants/constants.dart';
import 'package:flutter_mapp_clean_architecture/core/params/params.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_avatar/data/models/avatar_image_model.dart';
import '../../../../../core/errors/exceptions.dart';
import 'package:path_provider/path_provider.dart';

abstract class AvatarImageRemoteDataSource {
  Future<AvatarImageModel> getAvatarImage({required PokemonAvatarParams avatarImageParams});
}

class AvatarImageRemoteDataSourceImpl implements AvatarImageRemoteDataSource {
  final Dio dio;

  AvatarImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<AvatarImageModel> getAvatarImage({required PokemonAvatarParams avatarImageParams}) async {
    ///Get and delete the files saved in the directory first;
    Directory directory = await getApplicationDocumentsDirectory();
    directory.deleteSync(recursive: true);

    final String pathFile = '${directory.path}/${avatarImageParams.name}.png';

    //Get the response from the api call
    final response = await dio.download(
      avatarImageParams.imageUrl,
      pathFile
    );

    ///Directly saving the path of the avatarImage
    if (response.statusCode == 200) {
      return AvatarImageModel.fromJson(json: {kPath : pathFile});
    } else {
      throw ServerException();
    }
  }
}
