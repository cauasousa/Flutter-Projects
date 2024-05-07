import 'dart:io';

import 'package:contact_agenda/src/controllers/controllers.dart';
import 'package:contact_agenda/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ListContacts extends StatefulWidget {
  ListContacts(
      {super.key,
      required this.editContact,
      required this.listContact,
      required this.initializeListContact});

  Function({Contact contact}) editContact;

  List<Contact> listContact;
  Function() initializeListContact;
  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  ControllersContacts controllersCont = ControllersContacts();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listContact.length,
      itemBuilder: (context, index) {
        return _contactCard(context, index);
      },
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Card(
            shape: Border.all(
              width: 0.0,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            surfaceTintColor: Colors.white,
            shadowColor: const Color.fromARGB(255, 0, 0, 0),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                        
                        // ignore: unnecessary_null_comparison

                        image: widget.listContact[index].img != ''
                            ? FileImage(
                                File(widget.listContact[index].img.toString()))
                            : const AssetImage('images/person.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.listContact[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.listContact[index].email,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.listContact[index].number,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
      onTap: () {
        _opcionContacts(index);
      },
    );
  }

  _opcionContacts(int index) {
    showBottomSheet(

      context: context,
      builder: (context) {
        return BottomSheet(
          
          onClosing: () {},
          
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {

                        launchUrl(Uri(scheme: 'tel', path: widget.listContact[index].number));
                        Navigator.pop(context);

                      },
                      child: const Text(
                        "Link",
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.editContact(contact: widget.listContact[index]);
                      },
                      child: const Text("Edit",
                          style: TextStyle(color: Colors.red, fontSize: 18.0))),
                  TextButton(
                      onPressed: () {
                        
                        controllersCont.delete(widget.listContact[index].id!).then((value) {
                          Navigator.pop(context);

                          widget.initializeListContact();
                        });
                      },
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.red, fontSize: 18.0))),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
