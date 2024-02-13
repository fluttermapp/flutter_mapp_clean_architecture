import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/pokemon_image_entity.dart';

abstract class PokemonImageRepository {
  Future<({Failure? failure, PokemonImageEntity? pokemonImage})> getPokemonImage({
    required PokemonImageParams pokemonImageParams,
  });
}
