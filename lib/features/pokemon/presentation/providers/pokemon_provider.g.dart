// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonHash() => r'887da4280b9708926aab483aea57f3ca58c9529f';

/// See also [Pokemon].
@ProviderFor(Pokemon)
final pokemonProvider = AutoDisposeNotifierProvider<Pokemon,
    ({Failure? failure, PokemonEntity? pokemon})>.internal(
  Pokemon.new,
  name: r'pokemonProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pokemonHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Pokemon
    = AutoDisposeNotifier<({Failure? failure, PokemonEntity? pokemon})>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
