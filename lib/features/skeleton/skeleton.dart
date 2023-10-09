import 'package:flutter/material.dart';
import '../pokemon/presentation/pages/data_page.dart';
import '../pokemon/presentation/pages/pokemon_page.dart';

List<Widget> pages = const [
  PokemonPage(),
  DataPage(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return const Scaffold(
      body: PokemonPage(),
      //bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
