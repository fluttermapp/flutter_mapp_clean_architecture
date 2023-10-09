import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/core/constants/constants.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/avatar_entity.dart';
import '../../business/usecases/get_avatar.dart';
import '../../data/datasources/avatar_local_data_source.dart';
import '../../data/datasources/avatar_remote_data_source.dart';
import '../../data/repositories/avatar_repository_impl.dart';

class AvatarImageProvider extends ChangeNotifier {
  PokemonAvatarEntity? avatarImage;
  Failure? failure;

  AvatarImageProvider({
    this.avatarImage,
    this.failure,
  });

  void eitherFailureOrAvatarImage(
      {required PokemonEntity pokemonEntity}) async {
    AvatarImageRepositoryImpl repository = AvatarImageRepositoryImpl(
      remoteDataSource: AvatarImageRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: AvatarImageLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    String imageUrl = isShiny
        ? pokemonEntity.sprites.other.officialArtwork.frontShiny
        : pokemonEntity.sprites.other.officialArtwork.frontDefault;

    final failureOrAvatarImage =
        await GetPokemonAvatarUseCase(avatarRepository: repository).call(
      pokemonAvatarParams:
          PokemonAvatarParams(name: pokemonEntity.name, imageUrl: imageUrl),
    );
   
    failureOrAvatarImage.fold(
      (Failure newFailure) {
        avatarImage = null;
        failure = newFailure;
        notifyListeners();
      },
      (PokemonAvatarEntity newAvatarImage) {
        avatarImage = newAvatarImage;
        failure = null;
        notifyListeners();
      },
    );
  }
}
