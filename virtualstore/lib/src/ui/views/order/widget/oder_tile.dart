import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.orderuid});

  final String orderuid;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderuid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido: ${snapshot.data?.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_buildProductsText(snapshot.data!))

                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot documentSnapshot){
    String text = "Descrição:\n";
    
    Map data = documentSnapshot.data() as Map;

    for (LinkedHashMap elem in data['products']) {

      text+= "${elem['quantity']} x ${elem['product']['title']} (R\$ ${elem['product']['price'].toStringAsFixed(2)})\n";
    
    }

    text += "Total R\$ ${data['totalPrice'].toStringAsFixed(2)}";

    return text;

  }
}
