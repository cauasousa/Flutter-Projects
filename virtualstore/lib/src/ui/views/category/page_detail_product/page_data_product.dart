import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/models/cart_product.dart';
import 'package:virtualstore/src/models/product.dart';
import 'package:virtualstore/src/ui/views/cart/cart_screen.dart';
import 'package:virtualstore/src/ui/views/login/login_screen.dart';
import 'package:virtualstore/src/ui/views/widget/CustomElevatedButton.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class PageDetailProduct extends StatefulWidget {
  PageDetailProduct({super.key, required this.product});

  final Product product;

  @override
  State<PageDetailProduct> createState() => _PageDetailProductState();
}

class _PageDetailProductState extends State<PageDetailProduct> {
  String size = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: AnotherCarousel(
              images: widget.product.images.map((e) {
                return NetworkImage(e);
              }).toList(),

              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Color.fromARGB(121, 0, 0, 0),
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Color.fromARGB(255, 0, 0, 0),
              dotIncreaseSize: 2,
              autoplay: false,
              // borderRadius: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${widget.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                Text(
                  'Tamanho',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 34.0,

                  // width: double.maxFinite,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 8.0,
                    ),
                    children: widget.product.sizes.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = e;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: size == e
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Container(
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(
                      Users.of(context).isConnect()
                          ? 'Adicionar ao Carrinho'
                          : "Entre para Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                    // active: size != '',
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        size != '' ?Colors.black : Colors.grey.shade600,

                      ),
                       side: MaterialStatePropertyAll(BorderSide()),
                       shape: MaterialStatePropertyAll(LinearBorder()),
                    ),

                    onPressed: () {
                      if (!Users.of(context).isConnect()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        if(size != ''){
                    
                          CartProduct cardProduct = CartProduct();
                          print("Add card");
                          cardProduct.categoryUid = widget.product.categoryUid;
                          cardProduct.product = widget.product;
                          cardProduct.size = size;
                          cardProduct.productUid = widget.product.uidProduct;
                          cardProduct.quantity = 1;
                          CardModel.of(context).addCartItem(cardProduct);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Text(
                  'Descrição',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
