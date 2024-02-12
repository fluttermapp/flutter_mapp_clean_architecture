import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<({Failure? failure, PokemonEntity? pokemon})> getPokemon({required PokemonParams params});
}
