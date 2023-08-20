import 'package:flutter/material.dart';
import 'package:mapp_arch/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:mapp_arch/features/pokemon/presentation/providers/selected_page_provider.dart';
import 'package:mapp_arch/features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'package:mapp_arch/features/pokemon_image/presentation/providers/pokemon_image_provider.dart';
import 'package:mapp_arch/skeleton.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(
          create: (context) => SelectedPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedPokemonItemProvider(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SelectedPokemonItemProvider selectedPokemonItem =
        Provider.of<SelectedPokemonItemProvider>(context, listen: false);
    PokemonImageProvider pokemonImageProvider =
        Provider.of<PokemonImageProvider>(
      context,
      listen: false,
    );
    Provider.of<PokemonProvider>(context, listen: false).eitherFailureOrPokemon(
      value: (selectedPokemonItem.number + 1).toString(),
      pokemonImageProvider: pokemonImageProvider,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
