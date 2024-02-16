import 'package:flutter/material.dart';

class PageRestart extends StatelessWidget {
  PageRestart({super.key, required this.connection});

  final Function() connection;

  
  @override
  Widget build(BuildContext context) {
    return 
    Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4,
            color: Colors.white,
            size: 70,
          ),
          Padding(padding: EdgeInsets.all(12)),
          ElevatedButton(
            onPressed: () {
              connection();
            },
            child: Text(
              "Restart",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          )
        ],
      ),
    )
    ;
  }
}