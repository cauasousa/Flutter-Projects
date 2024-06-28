import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),

      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
        ),
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              )),
              hintText: "Digite seu CEP",
            ),
            initialValue: "",
            onFieldSubmitted: (value) {},
          ),
        ],
      ),
    );
  }
}
