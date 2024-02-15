import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/errors/failure.dart';
import '../../../pokemon_image/presentation/widgets/pokemon_image_widget.dart';
import '../../business/entities/pokemon_entity.dart';
import '../providers/pokemon_provider.dart';

class PokemonWidget extends ConsumerWidget {
  const PokemonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PokemonEntity? pokemon = ref.watch(pokemonProvider).pokemon;
    Failure? failure = ref.watch(pokemonProvider).failure;
    late Widget widget;
    if (pokemon != null) {
      widget = PokemonImageWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SingleChildScrollView(
                  child: FittedBox(
                    child: Text(
                      '#${pokemon.id} ${pokemon.name.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.black45,
                          ),
                        ],
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  pokemon.types.length,
                  (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      pokemon.types.elementAt(index).type.name.toUpperCase(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
