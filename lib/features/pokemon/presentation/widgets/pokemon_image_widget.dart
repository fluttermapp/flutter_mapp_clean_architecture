
import 'package:flutter/material.dart';


class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    widget = Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange,
          image: const DecorationImage(
            image: AssetImage('assets/images/mapp.png'),
          ),
        ),
        child: child,
      ),
    );
    return widget;
  }
}
