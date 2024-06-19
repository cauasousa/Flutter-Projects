import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/models/cart_product.dart';
import 'package:virtualstore/src/models/product.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.product});

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(product.categoryUid)
            .collection('itens')
            .doc(product.productUid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          } else {
            print(snapshot.data);
            print(snapshot.data!.id);
            print("AQUI");
            print(snapshot.data?.data());

            product.product = Product.fromMap(snapshot.data!);

            return Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product.product.images[0],
                    width: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          "Tamanho: ${product.size}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "R\$ ${product.product.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: product.quantity > 1 ?  () {
                                CardModel.of(context).desProduct(product);
                              } : null,
                              icon: Icon(Icons.remove),
                            ),
                            Text("${product.quantity}"),
                            IconButton(
                              onPressed: () {
                                CardModel.of(context).incProduct(product);
                              },
                              icon: Icon(Icons.add),
                              color: Theme.of(context).primaryColor,
                            ),
                            TextButton(
                              onPressed: () {
                                CardModel.of(context).removeCartItem(product);
                              },
                              child: Text("Remover"),
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                  Colors.grey[500],
                                ),
                                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
