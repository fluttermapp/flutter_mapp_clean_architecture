import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/pokemon/presentation/providers/pokemon_provider.dart';
import 'features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'features/skeleton/skeleton.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poke Mapp',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black87,
          )),
      home: const Home(),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    int selectedPokemonItem = ref.read(selectedPokemonItemProvider);
    ref.read(pokemonProvider.notifier).eitherFailureOrPokemon(value: (selectedPokemonItem + 1).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
