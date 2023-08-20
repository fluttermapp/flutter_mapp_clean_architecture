import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapp_arch/core/errors/failure.dart';
import 'package:mapp_arch/features/pokemon_image/business/entities/pokemon_image_entity.dart';
import 'package:mapp_arch/features/pokemon_image/presentation/providers/pokemon_image_provider.dart';
import 'package:provider/provider.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    PokemonImageEntity? pokemonImage =
        Provider.of<PokemonImageProvider>(context).pokemonImage;
    Failure? failure = Provider.of<PokemonImageProvider>(context).failure;
    late Widget widget;
    if (pokemonImage != null) {
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: FileImage(
                File(pokemonImage.path),
              ),
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
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    } else {
      widget = const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ),
        ),
      );
    }
    return widget;
  }
}
