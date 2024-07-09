import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/cart/cart_screen.dart';
import 'package:virtualstore/src/ui/views/category/pagecategory.dart';
import 'package:virtualstore/src/ui/views/drawer/customdrawer.dart';
import 'package:virtualstore/src/ui/views/home/home.dart';
import 'package:virtualstore/src/ui/views/order/order_screen.dart';
import 'package:virtualstore/src/ui/views/places/place_screen.dart';

const Color colos1 = Color.fromRGBO(76, 62, 165, 1);
const Color colos2 = Color.fromRGBO(14, 12, 63, 1);
const Color colos3 = Color.fromRGBO(37, 34, 114, 1);
const Color colos4 = Color.fromRGBO(0, 0, 12, 1);
const Color colos5 = Color.fromRGBO(61, 87, 140, 1);

class MyPages extends StatelessWidget {
  MyPages({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        PageHome(controller: _controller),
        PageCategory(controller: _controller),
        PlaceScreen(controller: _controller),
        PageOrder(controller: _controller),
      ],
    );
  }
}
