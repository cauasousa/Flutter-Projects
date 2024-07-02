import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/drawer/customdrawer.dart';
import 'package:virtualstore/src/ui/views/order/widget/body_page_order.dart';



class PageOrder extends StatelessWidget {
  const PageOrder({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        drawer: WidgetCustomDrawer(controller: controller, id: 3),
        appBar: AppBar(
          title: Text("Meus Pedidos"),
          backgroundColor: Color(0xFF154B52),
          centerTitle: true,
        ),
        body: BodyPageOrder(),
      ),
    );

  }
}