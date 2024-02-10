import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_bottom_bar_icon_widget.dart';
import '../providers/selected_page_provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;

    return SafeArea(
      child: BottomAppBar(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: selectedPage == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: LayoutBuilder(
                builder: (context, box) => SizedBox(
                  width: box.maxWidth / 2,
                  child: const Divider(
                    height: 0,
                    color: Colors.orangeAccent,
                    thickness: 2,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomBarIconWidget(
                  iconDataSelected: Icons.search_outlined,
                  iconDataUnselected: Icons.search_outlined,
                  callback: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(0);
                  },
                  isSelected: selectedPage == 0,
                ),
                CustomBottomBarIconWidget(
                  iconDataSelected: Icons.menu,
                  iconDataUnselected: Icons.menu,
                  callback: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(1);
                  },
                  isSelected: selectedPage == 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
