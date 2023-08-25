import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/pokemon_image_entity.dart';
import '../repositories/pokemon_image_repository.dart';

class GetPokemonImage {
  final PokemonImageRepository repository;

  GetPokemonImage(this.repository);

  Future<Either<Failure, PokemonImageEntity>> call({
    required PokemonImageParams params,
  }) async {
    return await repository.getPokemonImage(params: params);
  }
}
