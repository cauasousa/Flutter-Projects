import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/ui/views/cart/widget/cart_tile.dart';
import 'package:virtualstore/src/ui/views/cart/widget/discount_cart.dart';
import 'package:virtualstore/src/ui/views/cart/widget/price_cart.dart';
import 'package:virtualstore/src/ui/views/cart/widget/ship_card.dart';

class Cartbody extends StatelessWidget {
  const Cartbody({super.key, required this.onPressed});
  
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),

          child: Column(
            
            children: ScopedModel.of<CardModel>(context).products.map((e) {
              return CartTile(product: e);
            }).toList(),
          ),
        ),
        DiscountCard(),
        ShipCard(),
        PriceCart(onPressed: onPressed),
      ],
    );
  }
}
