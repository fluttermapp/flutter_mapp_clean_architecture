import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/core/errors/failure.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_image/business/entities/pokemon_image_entity.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_image/presentation/providers/pokemon_image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonImageWidget extends ConsumerWidget {
  const PokemonImageWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PokemonImageEntity? pokemonImageEntity = ref.watch(pokemonImageProvider.notifier).pokemonImage;
    Failure? failure = ref.watch(pokemonImageProvider.notifier).failure;
    late Widget widget;
    if (pokemonImageEntity != null) {
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: const DecorationImage(
              image: AssetImage('assets/images/mapp.png'),
            ),
          ),
          child: child,
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
          child: Center(
        child: Text(
          failure.errorMessage,
          style: const TextStyle(fontSize: 20.0),
        ),
      ));
    } else {
      widget = const Expanded(
          child: Center(
        child: CircularProgressIndicator.adaptive(),
      ));
    }
    return widget;
  }
}
