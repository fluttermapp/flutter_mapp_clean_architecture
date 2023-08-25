import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/constants/constants.dart';
import '../providers/pokemon_provider.dart';
import '../providers/selected_pokemon_item_provider.dart';
import 'custom_elevated_button_widget.dart';

class SearchPokemonWidget extends StatelessWidget {
  const SearchPokemonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    SelectedPokemonItemProvider selectedPokemonItem =
        Provider.of<SelectedPokemonItemProvider>(context);
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
                  selectedPokemonItem.changeNumber(
                    newNumber: Random().nextInt(maxPokemonId),
                  );
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
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
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
                                initialItem: selectedPokemonItem.number,
                              ),
                              onSelectedItemChanged: (int selectedItem) {
                                selectedPokemonItem.changeNumber(
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
                  '# ${selectedPokemonItem.number + 1}',
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
              Provider.of<PokemonProvider>(context, listen: false)
                  .eitherFailureOrPokemon(
                value: (selectedPokemonItem.number + 1).toString(),
              );
              if (await NetworkInfoImpl(DataConnectionChecker()).isConnected ==
                  false) {
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
