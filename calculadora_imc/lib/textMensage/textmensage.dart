import 'package:flutter/material.dart';
const color1 = Color.fromRGBO(25, 252, 0, 1);

// ignore: must_be_immutable
class TextMensage extends StatelessWidget {
  TextMensage({super.key, required this.mensage});
  
  String mensage;
  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mensage,
                style: TextStyle(
                  color: color1,
                  fontSize: 20,
                ),
              ),
            ],
          );
  }
}