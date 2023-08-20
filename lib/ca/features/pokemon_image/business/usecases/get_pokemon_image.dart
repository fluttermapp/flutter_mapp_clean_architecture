import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon_image/business/entities/pokemon_image_entity.dart';
import 'package:mapp_arch/features/pokemon_image/business/repositories/pokemon_image_repository.dart';

class GetPokemonImage {
  final PokemonImageRepository repository;

  GetPokemonImage(this.repository);

  Future<Either<Failure, PokemonImageEntity?>?> call({
    required PokemonImageParams params,
  }) async {
    return await repository.getPokemonImage(params: params);
  }
}
