import 'package:flutter/material.dart';

const color1 = Color.fromRGBO(25, 252, 0, 1);

// ignore: must_be_immutable
class TextFieldDesign extends StatelessWidget {

  TextFieldDesign({super.key, required this.label, required this.textError, required this.controllerText});

  TextEditingController controllerText;

  String label;
  String? textError;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerText,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      
      style: TextStyle(color: color1),
      
      decoration: InputDecoration(
        errorText: textError,
        
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          color: color1,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        border: UnderlineInputBorder(),
      ),
    );
  }
}
