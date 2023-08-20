import 'package:dartz/dartz.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/core/usecases/usecase.dart';
import 'package:mapp_arch/features/pokemon/business/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonEntity>> getPokemon({required PokemonParams params});
}
