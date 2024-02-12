import 'package:currency_converter/converters/abstratConverter.dart';
import 'package:flutter/material.dart';

class ConverterUSD extends ConverterText {
  TextEditingController currencyBRL;
  TextEditingController currencyUS;
  TextEditingController currencyEUR;

  ConverterUSD({
    required this.currencyBRL,
    required this.currencyUS,
    required this.currencyEUR,
  });

  @override
  void converterCurrency(double usdConverter) {
    this.updateCurrency();
    if (currencyUS.text != '') {
      var tempBRL = (usdConverter / ConverterText.usd);

      currencyBRL.text = ((tempBRL).toStringAsFixed(3)).toString();
      currencyEUR.text = ((tempBRL / ConverterText.eurJson).toStringAsFixed(3)).toString();
    } else {
      currencyBRL.text = '';
      currencyEUR.text = '';
    }
  }
}

