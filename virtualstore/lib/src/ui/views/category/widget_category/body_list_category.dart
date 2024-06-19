import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/category/widget_category/widget_tile.dart';

class BodyListCategory extends StatelessWidget {
  const BodyListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 200,
            alignment: Alignment.center,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          
          var divisor = ListTile.divideTiles(
            color: Colors.grey[500],
            tiles: snapshot.data?.docs.map((e) {
                  return WidgetTile(documentSnapshot: e);
                }) ??
                [],
          ).toList();

          return ListView(
            children: divisor,
          );
        }
      },
    );
  }
}
