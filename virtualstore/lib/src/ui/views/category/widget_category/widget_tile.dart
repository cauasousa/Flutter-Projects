import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/category/page_list_products/products_category_screen.dart';

class WidgetTile extends StatelessWidget {
  const WidgetTile({super.key, required this.documentSnapshot});

  final QueryDocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 20,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          documentSnapshot.get('icon'),
        ),
      ),
      title: Text(documentSnapshot.get('title')),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        // Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductCategoryScreen(snapshots: documentSnapshot),
          ),
        );
        
      },
    );
  }
}
