import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';

class WidgetTextCadastrar extends StatelessWidget {
  WidgetTextCadastrar({super.key, required this.cadastrar});

  final Function(BuildContext context, Users model) cadastrar;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      bottom: 0,
      child: ScopedModelDescendant<Users>(
        builder: (context, child, model) => GestureDetector(
          child: Text(
            model.isConnect() ? "Sair" : 'Entre ou cadastre-se >',
            style: TextStyle(
              // color: Color.fromARGB(255, 1, 109, 6),
              // color: Colors.black,
              color: Colors.greenAccent[700],
              // color: Color.fromARGB(255, 1, 128, 7),
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            cadastrar(context, model);
          },
        ),
      ),
    );
  }
}
