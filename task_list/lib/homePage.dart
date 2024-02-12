import 'package:flutter/material.dart';
import 'package:task_list/bodyWidget.dart';
import 'package:task_list/requestionJson.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Task List"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: FutureBuilder(
        future: readData().then((value) async {
          _data = value;
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Text(
                      "Awaiting datas",
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                  ],
                ),
              );
            
            default:
            
              if (!snapshot.hasError) {
                
                return BodyWidget(datas: _data);
              } else {
                

                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        "An error occurred, try restarting.",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
