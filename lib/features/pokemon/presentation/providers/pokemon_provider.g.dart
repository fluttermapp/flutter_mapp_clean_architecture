// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonHash() => r'33be7c3b4f16f1bbe68a4d68015454f5378d5c7d';

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
