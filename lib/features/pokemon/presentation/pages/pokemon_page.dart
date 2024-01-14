import 'package:flutter/material.dart';
import '../widgets/pokemon_widgets.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          PokemonWidget(),
          SearchPokemonWidget(),
        ],
      ),
    );
  }
}
