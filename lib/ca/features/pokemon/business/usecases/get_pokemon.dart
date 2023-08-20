import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:mapp_arch/features/pokemon/business/repositories/pokemon_repository.dart';

class GetPokemon {
  final PokemonRepository repository;

  GetPokemon(this.repository);

  Future<Either<Failure, PokemonEntity>> call({required PokemonParams params}) async {
    return await repository.getPokemon(params: params);
  }
}
