import 'package:flutter/material.dart';
import 'package:virtualstore/src/models/product.dart';
import 'package:virtualstore/src/ui/views/category/page_detail_product/page_data_product.dart';

class WidgetProductTile extends StatelessWidget {
  const WidgetProductTile(
      {super.key, required this.grid, required this.product});

  final bool grid;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageDetailProduct(product: product,),));
        },
        child: Container(
          child: grid
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "R\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.maxFinite,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "R\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
