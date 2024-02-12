import 'package:currency_converter/home/pageConversor/pageConversor.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '\$ Converter \$',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Color(0xFFF3B90B),

        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: PageConverter(),
      ),
    );
  }
}
