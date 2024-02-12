import 'package:currency_converter/converters/abstratConverter.dart';
import 'package:flutter/material.dart';

class ConverterEUR extends ConverterText {
  TextEditingController currencyBRL;
  TextEditingController currencyUS;
  TextEditingController currencyEUR;

  ConverterEUR({
    required this.currencyBRL,
    required this.currencyUS,
    required this.currencyEUR,
  });

  @override
  void converterCurrency(double eurConverter) {
    this.updateCurrency();
    if (currencyEUR.text != '') {
      var tempBRL = eurConverter / ConverterText.eur;
      currencyBRL.text = ((tempBRL).toStringAsFixed(3)).toString();

      currencyUS.text = ((tempBRL / ConverterText.usdJson).toStringAsFixed(3)).toString();
    } else {
      currencyBRL.text = '';
      currencyUS.text = '';
    }
  }
}
