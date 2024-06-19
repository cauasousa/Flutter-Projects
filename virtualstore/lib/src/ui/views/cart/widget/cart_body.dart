import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/ui/views/cart/widget/cart_tile.dart';

class Cartbody extends StatelessWidget {
  const Cartbody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      
      children: [
        Column(
          children: ScopedModel.of<CardModel>(context).products.map(
            (e) {
              return CartTile(product: e);
            }
          ).toList()
        )
      ],
    );
  }
}