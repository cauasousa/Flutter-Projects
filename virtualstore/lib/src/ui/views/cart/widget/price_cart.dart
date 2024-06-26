import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/ui/views/cart/orderScreen.dart';

class PriceCart extends StatelessWidget {
  const PriceCart({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CardModel>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumo do Pedido',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'R\$ ${model.getProductsPrice().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Desconto',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'R\$ ${model.getDiscount().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Entrega',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'R\$ ${model.getShipPrice().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$ ${model.getPriceTotal().toStringAsFixed(2)}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      "Finalizar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                      shape: MaterialStatePropertyAll(
                        ContinuousRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
