import 'package:calculadora_imc/buttonCalculator/buttonCalculate.dart';
import 'package:calculadora_imc/textField/textfiled.dart';
import 'package:calculadora_imc/textMensage/textmensage.dart';
import 'package:flutter/material.dart';

const color1 = Color.fromRGBO(25, 252, 0, 1);


// ignore: must_be_immutable
class PageHome extends StatefulWidget {
  PageHome({super.key, required this.text1, required this.text2, required this.textMensage, required this.textErrorPeso, required this.textErrorHeight, required this.calculateIMC});
  String textMensage;
  String? textErrorPeso;
  String? textErrorHeight;
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  final Function() calculateIMC;
  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(Icons.perm_identity, size: 100, color: color1),
              Padding(padding: EdgeInsets.all(4)),
              TextFieldDesign(label: 'Peso (kg)', textError: widget.textErrorPeso, controllerText: widget.text1),
              Padding(padding: EdgeInsets.all(4)),
              TextFieldDesign(label: 'Height (m)',textError: widget.textErrorHeight, controllerText: widget.text2),
              Padding(padding: EdgeInsets.all(12)),
              ButtonCalculate(calculateIMC: widget.calculateIMC),
              Padding(padding: EdgeInsets.all(4)),
              TextMensage(mensage: widget.textMensage),
            ],
          ),
        ),
      ],
    );
  }
}
