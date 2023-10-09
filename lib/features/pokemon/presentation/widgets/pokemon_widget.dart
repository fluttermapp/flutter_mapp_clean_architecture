import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/errors/failure.dart';
import '../../../pokemon_avatar/presentation/widgets/pokemon_image_widget.dart';
import '../../business/entities/pokemon_entity.dart';
import '../providers/pokemon_provider.dart';

class PokemonWidget extends StatelessWidget {
  const PokemonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonEntity? pokemon = Provider.of<PokemonProvider>(context).pokemon;
    Failure? failure = Provider.of<PokemonProvider>(context).failure;
    late Widget widget;
    if (pokemon != null) {
      widget = PokemonImageWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 20, top: kToolbarHeight),
              child: Text(
                'POKKE WORLD',
                style: TextStyle(
                  fontSize: 30,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.pink,
                    ),
                  ],
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
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
                  (index) => 
                  Text(
                    '#${pokemon.types.elementAt(index).type.name}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black38,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  // Chip(
                  //   label: Text(
                  //     pokemon.types.elementAt(index).type.name.toUpperCase(),
                  //     style: const TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.blueGrey,
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //   ),
                  //   side: const BorderSide(color: Colors.transparent),
                  // ),
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
