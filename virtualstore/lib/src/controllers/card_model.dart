import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/models/cart_product.dart';

class CardModel extends Model {
  CardModel({required this.users}) {
    if (users!.isConnect()) _loadCardItems();
  }

  Users? users;
  bool isloading = false;
  List<CartProduct> products = [];
  String? couponCode;
  double porcents = 0.0;

  static CardModel of(BuildContext context) =>
      ScopedModel.of<CardModel>(context);

  void addCartItem(CartProduct cardProduct) {
    products.add(cardProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(users!.user?.uid)
        .collection('cart')
        .add(cardProduct.toMap())
        .then((value) {
      cardProduct.cid = value.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cardProduct) {
    products.remove(cardProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(users!.user?.uid)
        .collection("cart")
        .doc(cardProduct.cid)
        .delete();

    notifyListeners();
  }

  void desProduct(CartProduct cardProduct) {
    cardProduct.quantity--;

    FirebaseFirestore.instance
        .collection('users')
        .doc(users!.user?.uid)
        .collection('cart')
        .doc(cardProduct.cid)
        .update(cardProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cardProduct) {
    cardProduct.quantity++;

    FirebaseFirestore.instance
        .collection('users')
        .doc(users!.user?.uid)
        .collection('cart')
        .doc(cardProduct.cid)
        .update(cardProduct.toMap());

    notifyListeners();
  }

  updatePrice(){
    notifyListeners();
  }

  double getProductsPrice() {
    double value = 0.0;

    for (CartProduct prod in products) {
      if (prod.product != null) {
        value += prod.quantity * prod.product!.price;
      }
    }

    return value;
  }

  double getDiscount() {
    if (porcents == 0.0) return 0.0;
    return -(getProductsPrice() * (porcents / 100));
  }

  double getShipPrice() {
    return 9.99;
  }

  double getPriceTotal() {
    return getProductsPrice() + getDiscount() + getShipPrice();
  }

  void _loadCardItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(users!.user?.uid)
        .collection('cart')
        .get();

    products = query.docs.map((e) {
      return CartProduct.fromDocument(e);
    }).toList();

    notifyListeners();
  }

  setCoupons(String? text, int porcent) {
    couponCode = text;
    porcents = double.parse("$porcent");
  }

  Future<String?> finishOrder() async{
    if(products.length == 0) return null;

    isloading = true;
    notifyListeners();
    double productPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();
    double totalPrice = getPriceTotal();

    DocumentReference refer = await FirebaseFirestore.instance.collection('orders').add({
      "clienteID": users?.user?.uid,
      "products": products.map((e) => e.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productPrice,
      "discount": discount,
      "totalPrice": totalPrice,
      "status": 1, 
    });

    FirebaseFirestore.instance.collection('users').doc(users?.user?.uid).collection('orders').doc(refer.id).set({
      "orderId": refer.id 
    });

    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").doc(users?.user?.uid).collection('cart').get();

    for (QueryDocumentSnapshot elem in query.docs){
      elem.reference.delete();
    }

    this.products.clear();
    this.couponCode = null;
    this.porcents = 0.0;
    
    isloading = false;
    notifyListeners();

    return refer.id;

  }
}
