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
