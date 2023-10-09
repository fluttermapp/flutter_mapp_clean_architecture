import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/avatar_entity.dart';
import '../repositories/avatar_repository.dart';

class GetPokemonAvatarUseCase {
  final AvatarRepository avatarRepository;

  GetPokemonAvatarUseCase({required this.avatarRepository});

  Future<Either<Failure, PokemonAvatarEntity>> call({
    required PokemonAvatarParams pokemonAvatarParams,
  }) async {
    return await avatarRepository.getAvatar(avatarParams: pokemonAvatarParams);
  }
}
