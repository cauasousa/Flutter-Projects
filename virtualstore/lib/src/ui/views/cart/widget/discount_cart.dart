import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/controllers/card_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
        ),
        leading: Icon(
          Icons.card_giftcard,
          color: Theme.of(context).primaryColor,
        ),
        trailing: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                hintText: "Digite seu cupom",
              ),
              initialValue: CardModel.of(context).couponCode ?? "",
              onFieldSubmitted: (value) {
                FirebaseFirestore.instance
                    .collection("coupons")
                    .doc(value)
                    .get()
                    .then((docSnap) {
                  if (docSnap.exists) {
                    CardModel.of(context).setCoupons( value, docSnap.get("percent"));
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Desconto de ${(docSnap.get("percent"))}% aplicado!"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      
                    );

                  }else{

                    CardModel.of(context).setCoupons( null, 0);

                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existente!"),
                        backgroundColor: Colors.redAccent,
                      ),
                      
                    );
                  }


                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
