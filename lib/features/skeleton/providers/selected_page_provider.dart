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