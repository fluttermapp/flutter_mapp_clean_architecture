import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  int selectedPage;

  SelectedPageProvider({
    this.selectedPage = 0,
  });

  void changePage(int newValue) {
    selectedPage = newValue;
    notifyListeners();
  }
}
