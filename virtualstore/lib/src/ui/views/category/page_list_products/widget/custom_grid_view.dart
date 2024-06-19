import 'package:flutter/material.dart';
import 'package:virtualstore/src/models/product.dart';
import 'package:virtualstore/src/ui/views/category/page_list_products/widget/widgetproductTile.dart';

class CustomGridViews extends StatelessWidget {

  const CustomGridViews({
    super.key,
    required this.cac,
    required this.cas,
    required this.mas,
    required this.ratio,
    required this.categoryUid,
    required this.snapshot,
    required this.grid,
  });

  final AsyncSnapshot snapshot;
  final int cac;
  final String categoryUid;
  final double cas, mas, ratio;
  final bool grid;

  @override
  Widget build(BuildContext context) {

    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cac,
        crossAxisSpacing: cas,
        mainAxisSpacing: mas,
        childAspectRatio: ratio,
      ),

      itemCount: snapshot.data?.docs.length,

      itemBuilder: (context, index) {

        Product product = Product.fromSnapshot(snapshot.data?.docs[index]);

        product.categoryUid = categoryUid; 

        return WidgetProductTile(
          grid: grid,
          product: product,
        );

      },

    );

  }

}
