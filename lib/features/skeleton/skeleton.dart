import 'package:flutter_mapp_clean_architecture/features/pokemon/presentation/pages/data_page.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon/presentation/pages/pokemon_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'providers/selected_page_provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';

List<Widget> pages = const [
  PokemonPage(),
  DataPage(),
];

class Skeleton extends ConsumerWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedPage = ref.watch(selectedPageProvider);
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
