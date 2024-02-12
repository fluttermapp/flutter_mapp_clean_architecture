// import 'package:flutter/material.dart';

// class SelectedPokemonItemProvider extends ChangeNotifier {
//   int number;

//   SelectedPokemonItemProvider({
//     this.number = 0,
//   });

//   void changeNumber({required int newNumber}) {
//     number = newNumber;
//     notifyListeners();
//   }
// }

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_pokemon_item_provider.g.dart';

@riverpod
class SelectedPokemonItem extends _$SelectedPokemonItem {
  @override
  int build() => 0;

  void changeNumber({required int newNumber}) {
    state = newNumber;
  }
}
