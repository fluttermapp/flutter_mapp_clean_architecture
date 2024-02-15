import 'package:flutter/material.dart';

class CustomBottomBarIconWidget extends StatelessWidget {
  const CustomBottomBarIconWidget({
    super.key,
    required this.callback,
    required this.iconDataSelected,
    required this.iconDataUnselected,
    required this.isSelected,
  });

  final VoidCallback callback;
  final bool isSelected;
  final IconData iconDataSelected;
  final IconData iconDataUnselected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      iconSize: isSelected ? 35 : 25,
      icon: Icon(
        isSelected ? iconDataSelected : iconDataUnselected,
        color: isSelected ? Colors.orangeAccent : Colors.black87,
      ),
    );
  }
}
