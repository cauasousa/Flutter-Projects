import 'package:currency_converter/converters/abstratConverter.dart';
import 'package:flutter/material.dart';

const color1 = Color(0xFFF3B90B);

// ignore: must_be_immutable
class ConverterTextField extends StatefulWidget {
  ConverterTextField({
    super.key,
    required this.label,
    required this.symbol,
    required this.currency,
    required this.recorrency,
  });

  String label;
  String symbol;
  TextEditingController currency;
  ConverterText recorrency;

  @override
  State<ConverterTextField> createState() => _ConverterTextFieldState();
}

class _ConverterTextFieldState extends State<ConverterTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: color1,
        fontSize: 16,
      ),
      keyboardType: TextInputType.number,
      controller: widget.currency,
      onChanged: (context) {
        widget.recorrency.converterCurrency(double.tryParse(widget.currency.text) ?? 0);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: color1,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: color1,
          ),
        ),
        label: Text(widget.label),
        labelStyle: TextStyle(
          color: color1,
          fontSize: 16,
        ),
        prefixText: widget.symbol,
        prefixStyle: TextStyle(
          color: color1,
          fontSize: 16,
        ),
      ),
    );
  }
}
