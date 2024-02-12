import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> _getFile() async {
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  

  return File("${appDocumentsDir.path}/data.json");
}

Future<File> savedata(_data) async {
  String jsonList = jsonEncode(_data);
  File file = await _getFile();

  return file.writeAsString(jsonList);
}

Future<dynamic> readData() async {
  try {
    

    final fileJson = await _getFile();
    
    final String jsonString = await fileJson.readAsString();
    
    return jsonDecode(jsonString);
    
  } catch (e) {

    return null;
  
  }
}
