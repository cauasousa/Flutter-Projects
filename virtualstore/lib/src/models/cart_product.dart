import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/models/product.dart';

class CartProduct extends Model{
  CartProduct();
  
  late String cid, categoryUid, productUid;
  late String size;
  late int quantity;
  Product ?product;
  
  static CartProduct of(BuildContext context) => ScopedModel.of<CartProduct>(context);

  CartProduct.fromDocument(QueryDocumentSnapshot? snapshot){

    if(snapshot != null){
      cid = snapshot.id;
      size = snapshot.get('size');
      quantity = snapshot.get("quantity");
      categoryUid = snapshot.get("categoryUid");
      productUid = snapshot.get("uidProduct");

    }

  }

  Map<String, dynamic> toMap(){

    // print("zz -> ${product.categoryUid}");
    // print("zz -> ${product.uidProduct}");

    return {
      
      "size" : size,
      "quantity" : quantity,
      "uidProduct" : product?.uidProduct,
      "categoryUid" : categoryUid,
      // "categoryUid" : product.categoryUid,
      "product" : product?.toResumeMap()
    };
  }

  

  

}