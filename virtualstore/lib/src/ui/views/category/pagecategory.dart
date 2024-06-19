import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/cart/cart_button.dart';
import 'package:virtualstore/src/ui/views/category/widget_category/body_list_category.dart';
import 'package:virtualstore/src/ui/views/drawer/customdrawer.dart';

class PageCategory extends StatelessWidget {
  const PageCategory({super.key, required this.controller});
  
  final PageController controller;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CartButton(),

        drawer: WidgetCustomDrawer(controller: controller, id: 1),
        appBar: AppBar(
          title: Text("Produtos"),
          backgroundColor: Color(0xFF154B52),
          centerTitle: true,
        ),
        body: BodyListCategory(),
      ),
    );
  }
}
