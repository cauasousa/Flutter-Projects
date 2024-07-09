import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyPlace extends StatelessWidget {
  const BodyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('places').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: snapshot.data!.docs.map((e) => _placeTile(e)).toList(),
          );
        }
      },
    );
  }

  Widget _placeTile(QueryDocumentSnapshot e) {
    Map data = e.data() as Map;
    final Uri _url_phone = Uri.parse('tel:${data['phone']}');
    final Uri _url_mapa = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${data['lat']},${data['long']}");

    print(data);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Image.network(
              data['image'],
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['address'],
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
                ),
                onPressed: () {
                  launchUrl(_url_mapa);
                },
                child: Text(
                  'Ver Mapa',
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
                ),
                onPressed: () {
                  launchUrl(_url_phone);
                },
                child: Text(
                  'Ligar',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
