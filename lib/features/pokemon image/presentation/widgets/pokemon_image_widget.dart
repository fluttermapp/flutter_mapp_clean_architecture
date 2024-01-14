import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/core/errors/failure.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon%20image/business/entities/pokemon_image_entity.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon%20image/presentation/providers/pokemon_image_provider.dart';
import 'package:provider/provider.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    PokemonImageEntity? notifier = context.watch<PokemonImageProvider>().pokemonImage;
    Failure? failure = Provider.of<PokemonImageProvider>(context).failure;
    late Widget widget;
    if (notifier != null) {
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image:  DecorationImage(
              image: FileImage(File(notifier.path)),
            ),
          ),
          child: child,
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
        child: Center(
          child: Text(failure.errorMessage),
        ),
      );
    } else {
      widget = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return widget;
  }
}
