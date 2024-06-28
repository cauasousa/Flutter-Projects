import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
        ),
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        // trailing: Icon(
        //   Icons.add,
        //   color: Theme.of(context).primaryColor,
        // ),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                )),
                hintText: "Digite seu cupom",
              ),
              initialValue: "",
              onFieldSubmitted: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
