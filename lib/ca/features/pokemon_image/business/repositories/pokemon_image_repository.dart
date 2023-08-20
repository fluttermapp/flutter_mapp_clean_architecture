import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon_image/business/entities/pokemon_image_entity.dart';

abstract class PokemonImageRepository {
  Future<Either<Failure, PokemonImageEntity?>>? getPokemonImage({
    required PokemonImageParams params,
  });
}
