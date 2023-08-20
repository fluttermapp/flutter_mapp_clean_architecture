import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemon {
  final PokemonRepository repository;

  GetPokemon(this.repository);

  Future<Either<Failure, PokemonEntity>> call({required PokemonParams params}) async {
    return await repository.getPokemon(params: params);
  }
}
