import 'dart:convert';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searching_gifs/ui/pagehome/PageListGifs/pageBoxGifs.dart';
import 'package:searching_gifs/ui/pageRestart/pageRestart.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  String? search = null;
  int _offset = 0;

  var screen = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Searching for GIFs",
      home: screen
          ? SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Image.network(
                  'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif',
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.gif,
                      color: Colors.white,
                    );
                  },
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    
                    
                    TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: 'Search here!',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ) // enabledBorder: OutlineInputBorder(borderSide: BorderSide())
                        
                          ),
                      onChanged: (value) {
                        setState(() {
                          search = controller.text == ''
                              ? null
                              : controller.text;
                        });
                        _offset = 0;
                        
                        _getGiF().catchError((e) {
                          connection();
                        });
                      },
                    ),
                    
                    
                    Padding(padding: EdgeInsets.all(4)),
                    Expanded(
                      child: FutureBuilder(
                        future: _getGiF(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                            default:
                              if (snapshot.hasError) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Error with connection!!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              } else {
                                return ListBoxGifs(
                                  snapshot: snapshot,
                                  increment_offset: increment_offset,
                                );
                              }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          // : PageRestart(connection: connection),
          : PageRestart(connection: connection),
    );
  }

  void increment_offset() {
    setState(() {
      _offset += 19;
    });
  }

  Future<void> connection() async {
    if (await ConnectivityWrapper.instance.isConnected == true) {
      // conectado
      setState(() {
        screen = true;
      });
    } else {
      // not conectado
      setState(() {
        screen = false;
      });
    }
  }

  Future<dynamic> _getGiF() async {
    var url;

    if (search != null) {
      url = Uri.parse(yourKEY1); 
    } else {
      url = Uri.parse(YourKey);
    }

    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}
