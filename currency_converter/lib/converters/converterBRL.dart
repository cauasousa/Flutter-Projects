import 'package:currency_converter/converters/abstratConverter.dart';
import 'package:flutter/material.dart';


class ConverterBRL extends ConverterText {
  TextEditingController currencyBRL;
  TextEditingController currencyUS;
  TextEditingController currencyEUR;

  ConverterBRL({
    required this.currencyBRL,
    required this.currencyUS,
    required this.currencyEUR,
  });

  @override
  void converterCurrency(double brlConverter) {
    this.updateCurrency();

    if (currencyBRL.text != '') {
      currencyEUR.text = ((ConverterText.eur * brlConverter).toStringAsFixed(3)).toString();
      currencyUS.text = ((ConverterText.usd * brlConverter).toStringAsFixed(3)).toString();
    } else {
      currencyEUR.text = '';
      currencyUS.text = '';
    }
  }

  
}
