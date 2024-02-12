import 'package:currency_converter/converters/abstratConverter.dart';
import 'package:currency_converter/converters/converterBRL.dart';
import 'package:currency_converter/converters/converterEUR.dart';
import 'package:currency_converter/converters/converterUSD.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/home/pageConversor/textField/textfied.dart';

class PageConverter extends StatefulWidget {
  const PageConverter({super.key});

  @override
  State<PageConverter> createState() => _PageConverterState();
}

class _PageConverterState extends State<PageConverter> {
  TextEditingController currencyBRL = TextEditingController();
  TextEditingController currencyUS = TextEditingController();
  TextEditingController currencyEUR = TextEditingController();

  late ConverterBRL recorrencyBRL = ConverterBRL(
      currencyBRL: currencyBRL,
      currencyUS: currencyUS,
      currencyEUR: currencyEUR);
  late ConverterEUR recorrencyEUR = ConverterEUR(
      currencyBRL: currencyBRL,
      currencyUS: currencyUS,
      currencyEUR: currencyEUR);
  late ConverterUSD recorrencyUSD = ConverterUSD(
      currencyBRL: currencyBRL,
      currencyUS: currencyUS,
      currencyEUR: currencyEUR);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requisition(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Text(
                "Waiting to load .......",
                style: TextStyle(
                  color: Color.fromARGB(255, 34, 255, 0),
                ),
              ),
            );
          // ignore: dead_code
          default:
            
            if (snapshot.hasError != true) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on,
                          size: 116, color: Color(0xFFF3B90B)),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      ConverterTextField(
                        label: 'Reais',
                        symbol: 'R\$',
                        currency: currencyBRL,
                        recorrency: recorrencyBRL,
                      ),
                      
                      Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      ConverterTextField(
                        label: 'Dólares',
                        symbol: 'US\$',
                        currency: currencyUS,
                        recorrency: recorrencyUSD,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      ConverterTextField(
                        label: 'Euros',
                        symbol: '€',
                        currency: currencyEUR,
                        recorrency: recorrencyEUR,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "An error occurred, try restarting.",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
