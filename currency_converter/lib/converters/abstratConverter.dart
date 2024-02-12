import 'dart:convert';
import 'package:http/http.dart' as http;

var url = Uri.parse('http://api.hgbrasil.com/finance?key=f7d6b602'); 

abstract class ConverterText {
  static var real, usd, eur, usdJson, eurJson = 0.0;

  Future<void> updateCurrency() async {
    requisition();
  }

  void converterCurrency(double valor);
}

Future<bool> requisition() async {
  
  http.Response response = await http.get(url);

  var decodedResponse = jsonDecode(response.body) as Map;

  ConverterText.usdJson = decodedResponse['results']['currencies']['USD']['buy'];

  ConverterText.eurJson = decodedResponse['results']['currencies']['EUR']['buy'];

  ConverterText.real = 1;
  ConverterText.usd = 1 / ConverterText.usdJson;
  ConverterText.eur = 1 / ConverterText.eurJson;
  
  return true;
}
