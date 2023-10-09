import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/core/errors/failure.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_avatar/business/entities/avatar_entity.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_avatar/presentation/providers/avatar_image_provider.dart';
import 'package:provider/provider.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    PokemonAvatarEntity? pokemonAvatarEntity =
        Provider.of<AvatarImageProvider>(context).avatarImage;
    Failure? failure = Provider.of<AvatarImageProvider>(context).failure;
    late Widget widget;
    if (pokemonAvatarEntity != null) {
      widget = Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.scaleDown,
              image: FileImage(File(pokemonAvatarEntity.avatarPath)),
            ),
          ),
          child: child
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
          child: Center(
        child: Text(
          failure.errorMessage,
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      widget = const Expanded(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return widget;
  }
}
