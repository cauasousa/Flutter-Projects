import 'package:contact_agenda/src/controllers/controllers.dart';
import 'package:contact_agenda/src/models/contact.dart';
import 'package:contact_agenda/src/ui/views/contactPage/contactpage.dart';
import 'package:contact_agenda/src/ui/views/myhome/listcontacts/listContact.dart';
import 'package:flutter/material.dart';

enum OrderOptions { orderAz, orderZa }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ControllersContacts controllersCont = ControllersContacts();
  List<Contact> listContact = List.empty(growable: true);

  @override
  void initState() {
    // var cont = Contact();
    // cont.name = "lindo";
    // cont.email = "lindo@gmail.com";
    // cont.number = "8888888";
    // controllersCont.add(cont).then((value) {
    //   controllersCont.readALL().then((value) {
    //     print(value);
    //   });
    // });

    super.initState();
    // controllersCont.delete(1);
    // controllersCont.delete(2);
    // controllersCont.delete(5);

    initializeListContact();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Contact', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            PopupMenuButton<OrderOptions>(
              onSelected: _onSelectionBarraMenu,
              itemBuilder: (context) {
                return <PopupMenuEntry<OrderOptions>>[
                  const PopupMenuItem(
                    value: OrderOptions.orderAz,
                    child: Text('Order of A-Z'),
                  ),
                  const PopupMenuItem(
                    value: OrderOptions.orderZa,
                    child: Text('Order of Z-A'),
                  ),
                ];
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showContactPage,
          shape: const CircleBorder(side: BorderSide.none),
          backgroundColor: Colors.red,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.white,
        body: ListContacts(
            editContact: showContactPage,
            listContact: listContact,
            initializeListContact: initializeListContact),
      ),
    );
  }

  void showContactPage({Contact? contact}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                  initializeListContact: initializeListContact,
                )));
  }

  void initializeListContact() {
    controllersCont.readALL().then((value) {
      setState(() {
        listContact = value;
      });
    });
  }

  _onSelectionBarraMenu(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAz:
        print("AZ");

        setState(() {
          listContact.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        });
        // initializeListContact();
        break;
      case OrderOptions.orderZa:
        print("ZA");

        setState(() {
          listContact.sort(
              (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        });
        // initializeListContact();
        break;
      default:
    }
  }
}
