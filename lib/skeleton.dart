import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/core/template/presentation/pages/template_page.dart';

List<Widget> pages = const [
  TemplatePage(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Poke-Mapp'),
      ),
      body: pages[0],
    );
  }
}
