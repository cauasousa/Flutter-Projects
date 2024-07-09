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
              int firebaseStatus = snapshot.data?['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido: ${snapshot.data?.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_buildProductsText(snapshot.data!)),
                  Padding(padding: EdgeInsets.all(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatus('1', "Preparação", firebaseStatus, 1),
                      Container(
                        color: Colors.grey[500],
                        width: 40,
                        height: 4,
                      ),
                      _buildStatus('2', "Transporte", firebaseStatus, 2),
                      Container(
                        color: Colors.grey[500],
                        width: 40,
                        height: 4,
                      ),
                      _buildStatus('3', "Entrega", firebaseStatus, 3),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot documentSnapshot) {
    String text = "Descrição:\n";

    Map data = documentSnapshot.data() as Map;

    for (LinkedHashMap elem in data['products']) {
      text +=
          "${elem['quantity']} x ${elem['product']['title']} (R\$ ${elem['product']['price'].toStringAsFixed(2)})\n";
    }

    text += "Total R\$ ${data['totalPrice'].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildStatus(
      String title, String subTitle, int status, int thisStatus) {
    Color? back;
    Widget child;

    if (status < thisStatus) {
      back = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      back = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ],
      );
    } else {
      back = Colors.green;
      child = Icon(Icons.check, color: Colors.white);
    }

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: back,
          radius: 20,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
