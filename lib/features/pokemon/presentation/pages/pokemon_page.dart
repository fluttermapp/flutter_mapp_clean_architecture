import 'package:flutter/material.dart';
import '../widgets/pokemon_widgets.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff93A5CF),
            Color(0xffE4EfE9)
          ])
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PokemonWidget(),
            SearchPokemonWidget(),
          ],
        ),
      ),
    );
  }
}
