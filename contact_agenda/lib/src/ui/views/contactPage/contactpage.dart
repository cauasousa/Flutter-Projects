import 'dart:io';

import 'package:contact_agenda/src/controllers/controllers.dart';
import 'package:contact_agenda/src/models/contact.dart';
import 'package:contact_agenda/src/ui/views/contactPage/showAlert/showalert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ContactPage extends StatefulWidget {
  ContactPage({super.key, this.contact, required this.initializeListContact});

  Contact? contact;
  Function() initializeListContact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editedContact;
  bool _edit = false;
  String? textError;
  TextEditingController namecontrolers = TextEditingController();
  TextEditingController numbercontrolers = TextEditingController();
  TextEditingController emailcontrolers = TextEditingController();

  final ControllersContacts _controllersCont = ControllersContacts();
  FocusNode nameFocusNode = FocusNode();
  String? pathPhoto;

  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      _editedContact = Contact.fromMap(widget.contact!.toMap());
      namecontrolers.text = _editedContact!.name;
      numbercontrolers.text = _editedContact!.number;
      emailcontrolers.text = _editedContact!.email;
      pathPhoto = _editedContact!.img == '' ? null : _editedContact!.img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _editedContact != null ? _editedContact!.name : "New Contact",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.red,
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(side: BorderSide.none),
            backgroundColor: Colors.red,
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: adicioneContact,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imagePerson(),
                        ),
                      ),
                    ),
                    onTap: () {
                      final ImagePicker picker = ImagePicker();
                      picker
                          .pickImage(source: ImageSource.camera)
                          .then((value) {
                        if (value != null) {
                          _edit = true;
                          setState(() {
                            pathPhoto = value.path;
                          });
                          

                          if (_editedContact != null) {
                            _editedContact!.img = pathPhoto!;
                          }

                        }
                      });
                    },
                  ),
                  TextField(
                    controller: namecontrolers,
                    focusNode: nameFocusNode,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        errorText: textError,
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    onChanged: (value) {
                      if (value != '') {
                        setState(() {
                          textError = null;
                          _edit = true;
                          if (_editedContact != null) {
                            _editedContact!.name = value;
                          }
                        });
                      }
                    },
                  ),
                  TextField(
                    controller: emailcontrolers,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      _edit = true;
                      if (_editedContact != null) {
                        _editedContact!.email = value;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: numbercontrolers,
                    decoration: const InputDecoration(
                      labelText: 'Number',
                    ),
                    onChanged: (value) {
                      _edit = true;
                      if (_editedContact != null) {
                        _editedContact!.number = value;
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void adicioneContact() async {
    if (_edit == true) {
      if (namecontrolers.text != '') {
        if (_editedContact != null) {
          _controllersCont.update(_editedContact!);
        } else {
          Contact addCont = Contact();
          addCont.name = namecontrolers.text;
          addCont.email = emailcontrolers.text;
          addCont.number = numbercontrolers.text;
          addCont.img = pathPhoto ?? '';

          _controllersCont.add(addCont);
        }
        widget.initializeListContact();
        Navigator.pop(context);
        return;
      }
    }
    FocusScope.of(context).requestFocus(nameFocusNode);
    setState(() {
      textError = "Insertion name.";
    });
  }

  _requestPop(bool value) {
    if (value == false) {
      if (_edit) {
        showAlert(context);
      } else {
        Navigator.pop(context);
      }
    }
  }

  ImageProvider imagePerson() {
    if (pathPhoto != null) {
      return FileImage(File(pathPhoto!));
    }

    return const AssetImage('images/person.png');
  }
}
