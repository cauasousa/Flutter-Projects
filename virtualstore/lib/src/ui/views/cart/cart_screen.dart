import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/cart/orderScreen.dart';
import 'package:virtualstore/src/ui/views/cart/widget/cart_body.dart';
import 'package:virtualstore/src/ui/views/login/login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meus Pedidos"),
          backgroundColor: Color(0xFF1C8394),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 12),
              child: ScopedModelDescendant<CardModel>(
                builder: (context, child, model) {
                  int tam = model.products.length;
                  return Text(
                    '${tam != 0 ? tam : 0} ${tam > 1 ? "ITENS" : "ITEM"}',
                    style: TextStyle(fontSize: 17),
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          child: ScopedModelDescendant<CardModel>(
            builder: (context, child, model) {
              if (model.isloading &&
                  ScopedModel.of<Users>(context).isConnect()) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!ScopedModel.of<Users>(context).isConnect()) {
                return Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 80.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(padding: EdgeInsets.all(12.0)),
                      Text(
                        "Faça o login para adicionar produtos!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(padding: EdgeInsets.all(12.0)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                          shape: MaterialStatePropertyAll(
                            LinearBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (model.products.isEmpty || model.products.length == 0) {
                return Center(
                  child: Text(
                    "Nenhum produto no carrinho!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Cartbody(onPressed: () async {
                  String? idcart = await model.finishOrder();
                  if (idcart != null) {
                    print('Comprou Acertou************');

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(id: idcart),
                      ),
                    );
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
