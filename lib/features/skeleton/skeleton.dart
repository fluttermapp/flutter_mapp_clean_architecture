import 'package:flutter/material.dart';
import '../pokemon/presentation/pages/data_page.dart';
import '../pokemon/presentation/pages/pokemon_page.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';
import 'providers/selected_page_provider.dart';

List<Widget> pages = const [
  PokemonPage(),
  DataPage(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Poke-Mapp'),
      ),
      body: pages[selectedPage],
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
