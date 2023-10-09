import 'package:dartz/dartz.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_avatar/business/entities/avatar_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';


abstract class AvatarRepository {
  Future<Either<Failure, PokemonAvatarEntity>> getAvatar({
    required PokemonAvatarParams avatarParams,
  });
}
