import 'package:flutter/material.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/login/login_screen.dart';

class BodyPageOrder extends StatelessWidget {
  const BodyPageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    if (Users.of(context).isConnect()) {

      
      return Container();


    } else {
      return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            Padding(padding: EdgeInsets.all(12.0)),
            Text(
              "Faça o login para acompanhar o seu pedido",
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
    }
  }
}
