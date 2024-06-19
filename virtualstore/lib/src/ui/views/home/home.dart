import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/cart/cart_button.dart';
import 'package:virtualstore/src/ui/views/drawer/customdrawer.dart';
import 'package:virtualstore/src/ui/views/home/widget/appbar_sliver.dart';
import 'package:virtualstore/src/ui/views/home/widget/build_body_back.dart';
import 'package:virtualstore/src/ui/views/home/widget/widgetStaggeredGridTile.dart';

class PageHome extends StatelessWidget {
  PageHome({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CartButton(),
        drawer: WidgetCustomDrawer(controller: controller, id: 0),
        body: Stack(
          children: [
            BuildBodyBack(),
            CustomScrollView(
              slivers: [
                const AppBarSliver(),
                const StaggeredGridTileAdaptative(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
