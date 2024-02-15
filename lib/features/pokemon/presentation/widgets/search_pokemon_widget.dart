import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:flutter_mapp_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_mapp_clean_architecture/core/constants/constants.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon/presentation/providers/providers.dart';

import 'custom_elevated_button_widget.dart';

class SearchPokemonWidget extends ConsumerWidget {
  const SearchPokemonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
    final int selectedPokemonItem = ref.watch(selectedPokemonItemProvider);
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 40.0,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 10.0,
            runSpacing: 5.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(selectedPokemonItemProvider.notifier).changeNumber(
                        newNumber: Random().nextInt(maxPokemonId),
                      );
                  final int newNumber = ref.read(selectedPokemonItemProvider) +1;
                  ref.read(pokemonProvider.notifier).eitherFailureOrPokemon(value: newNumber.toString());
                },
                child: const Text(
                  'Random',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 216,
                    padding: const EdgeInsets.only(top: 6.0),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: const Text('Done'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: SafeArea(
                            top: false,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              scrollController: FixedExtentScrollController(
                                initialItem: selectedPokemonItem,
                              ),
                              onSelectedItemChanged: (int selectedItem) {
                                ref.read(selectedPokemonItemProvider.notifier).changeNumber(
                                      newNumber: selectedItem,
                                    );
                              },
                              children: List<Widget>.generate(
                                maxPokemonId,
                                (int index) {
                                  return Center(
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Text(
                  '# ${selectedPokemonItem + 1}',
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ],
          ),
          CustomElevatedButtonWidget(
            buttonColor: Colors.orangeAccent,
            textColor: Colors.white,
            iconColor: Colors.white,
            callback: () async {
              ref.read(pokemonProvider.notifier).eitherFailureOrPokemon(
                    value: (selectedPokemonItem + 1).toString(),
                  );
              if (await NetworkInfoImpl(DataConnectionChecker()).isConnected == false) {
                scaffoldMessengerState.clearSnackBars();
                scaffoldMessengerState.showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.orange,
                    content: Text('No connection'),
                    showCloseIcon: true,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
