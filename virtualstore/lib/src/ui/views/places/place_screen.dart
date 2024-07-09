import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/drawer/customdrawer.dart';
import 'package:virtualstore/src/ui/views/places/widget/body_place.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            drawer: WidgetCustomDrawer(controller: controller, id: 2),
            appBar: AppBar(
              title: Text("Lojas"),
              backgroundColor: Color(0xFF390D02),
              centerTitle: true,
            ),
            body: BodyPlace(),
          ),
        );
  }
}