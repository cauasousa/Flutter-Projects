import 'package:calculadora_imc/appBar/appbar.dart';
import 'package:calculadora_imc/homePage/page/page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  String textMensage = "Provide your data!";
  String? textErrorHeight = null;
  String? textErrorPeso = null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarDesign(fncRestart: restartText),
        body: PageHome(
            text1: text1,
            text2: text2,
            textMensage: textMensage,
            calculateIMC: calculateIMC,
            textErrorHeight: textErrorHeight,
            textErrorPeso: textErrorPeso),
      ),
    );
  }

  void restartText() {
    setState(() {
      text1.text = '';
      text2.text = '';
      textMensage = "Provide your data!";
      textErrorHeight = null;
      textErrorPeso = null;
    });
  }

  void calculateIMC() {
    var peso = double.tryParse(text1.text);
    var height = double.tryParse(text2.text);

    if (peso != null && height != null && peso > 0 && height > 0) {
      var result = peso / (height * height);

      String temp = "\2794";

      if (result >= 40) {
        temp = "\u2192Grade III obesity or morbid ";
      } else if (result >= 35 && result <= 39.9) {
        temp = "\u2192Grade II obesity";
      } else if (result >= 30 && result <= 34.9) {
        temp = "\u2192Grade I obesity";
      } else if (result >= 24.9 && result <= 29.9) {
        temp = "\u2192Overweight";
      } else if (result >= 18.5 && result <= 24.9) {
        temp = "\u2192Normal peso";
      } else if (result < 18.5) {
        temp = "\u2192Under peso";
      }
      setState(() {
        textErrorPeso = null;
        textErrorHeight = null;
        textMensage = """
\u2192IMC - ${result.toStringAsFixed(2)}
${temp}
                    """;
      });
    } else {
      setState(() {
        if (peso == null) textErrorPeso = 'Provide your Peso. Ex.: 86.7';
        if (height == null) textErrorHeight = 'Provide your Height. Ex.: 1.75';
        textMensage = "Provide your data!";
      });
    }
  }
}
