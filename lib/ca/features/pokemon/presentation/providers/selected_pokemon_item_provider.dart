import 'package:flutter/material.dart';

class SelectedPokemonItemProvider extends ChangeNotifier {
  int number;

  SelectedPokemonItemProvider({
    this.number = 0,
  });

  void changeNumber({required int newNumber}) {
    number = newNumber;
    notifyListeners();
  }
}
