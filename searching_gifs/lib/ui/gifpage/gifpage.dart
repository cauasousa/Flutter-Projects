import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifPage extends StatelessWidget {
  GifPage(this._data, {super.key});

  final Map _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          _data["title"],
        ),
        centerTitle: true,  
        actions: [
          IconButton(
              onPressed: () {
                Share.share("This is URL of Gif: ${_data["images"]["fixed_height"]["url"]}");
              },
              icon: Icon(
                Icons.share,
                
              ))
        ],
      ),
      body: Center(
        child: Image.network(_data["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
