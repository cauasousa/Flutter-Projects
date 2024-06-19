import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/models/cart_product.dart';


class CardModel extends Model{

  CardModel({required this.users}){
    
    if(users!.isConnect())
      _loadCardItems();
  
  }

  Users? users;
  bool isloading = false;
  List<CartProduct> products= [];

  static CardModel of(BuildContext context) => ScopedModel.of<CardModel>(context);

  void addCartItem(CartProduct cardProduct){
    products.add(cardProduct);
    
    FirebaseFirestore.instance.collection('users').doc(users!.user?.uid).collection('cart').add(cardProduct.toMap()).then((value) {
      cardProduct.cid = value.id;
    });
    
    notifyListeners();
  }

  void removeCartItem(CartProduct cardProduct){
    products.remove(cardProduct);

    FirebaseFirestore.instance.collection('users').doc(users!.user?.uid).collection("cart").doc(cardProduct.cid).delete();
    
    notifyListeners();
  }

  void desProduct(CartProduct cardProduct){
    cardProduct.quantity--;

    FirebaseFirestore.instance.collection('users').doc(users!.user?.uid).collection('cart').doc(cardProduct.cid).update(cardProduct.toMap());
    
    notifyListeners();

  }
  void incProduct(CartProduct cardProduct){

    cardProduct.quantity++;

    FirebaseFirestore.instance.collection('users').doc(users!.user?.uid).collection('cart').doc(cardProduct.cid).update(cardProduct.toMap());
    
    notifyListeners();

  }

  void _loadCardItems() async {
    
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(users!.user?.uid).collection('cart').get();
    
    products = query.docs.map((e) {
      
       return CartProduct.fromDocument(e);
    } ).toList();

  }
}