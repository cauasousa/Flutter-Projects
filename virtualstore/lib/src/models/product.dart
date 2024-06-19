import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  late String uidProduct, categoryUid;
  late String title, description;
  late double price;
  late List images, sizes;
  
  Product.fromSnapshot(QueryDocumentSnapshot? snapshot){
    
    if(snapshot == null){
      print("Error in Products");
      return;
    }
    
    uidProduct = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get("description");
    price = double.tryParse('${snapshot.get("price")}') ?? 0.0;
    images = snapshot.get("images");
    sizes = snapshot.get("sizes");
  }

  Product.fromMap(DocumentSnapshot documentSnapshot){
    
    Map data = documentSnapshot.data() as Map;
    // print("OPA");
    // print(data);
    
    uidProduct = documentSnapshot.id;
    // categoryUid = data["categoryUid"];
    title = data['title'];
    description = data["description"];
    price = double.parse("${data['price']}");
    images = data["images"];
    
  }

  Map<String, dynamic> toMap(){
    return {
      // "categoryUid" : categoryUid,
      "uidProduct" : uidProduct,
      "title" : title,
      "description" : description,
      "price" : price,
      "images" : images
    };
  }

  Map<String, dynamic> toResumeMap(){
    
    return {
      "title" : title,
      "description": description,
      "price" : price
    };
  }

}