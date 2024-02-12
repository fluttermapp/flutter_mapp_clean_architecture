// import 'package:flutter/material.dart';

// class SelectedPageProvider extends ChangeNotifier {
//   int selectedPage;

//   SelectedPageProvider({
//     this.selectedPage = 0,
//   });

//   void changePage(int newValue) {
//     selectedPage = newValue;
//     notifyListeners();
//   }
// }

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_page_provider.g.dart';

@riverpod
class SelectedPage extends _$SelectedPage {
  @override
   int build() => 0;

   void changePage(int newValue) {
    state = newValue;
   }
}