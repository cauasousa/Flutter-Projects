import 'dart:io';
import 'package:chatflutter/src/Models/users.dart';
import 'package:chatflutter/src/Views/chatpage/widgets/box_mensage.dart';
import 'package:chatflutter/src/Views/chatpage/widgets/custom_drawer.dart';
import 'package:chatflutter/src/Views/chatpage/widgets/textcomposer.dart';
import 'package:chatflutter/src/Views/myapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const String senderPhotoUrl = "senderPhotoUrl";
const String senderName = "senderName";
const String uid = "uid";
const String imgUrl = "imgUrl";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final Users _user = Users();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        _user.user = event;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        
        // drawerScrimColor: Colors.black,
        
        drawer: Custom_Drawer(name: _user.nameUser,),

        appBar: AppBar(

          foregroundColor: Colors.white,

          title: Text(_user.ativate == true ? 'Olá, ${_user.nameUser!}' : 'Chat App'),

          centerTitle: true,

          backgroundColor: Colors.lightBlue,

          actions: [
            _user.ativate == false
                ? Container()
                : IconButton(
                    onPressed: () async {
 
                      await _user.outUser();

                      scaffoldMessengerKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Você saiu com sucesso!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                    ),
                  ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {

                    case ConnectionState.none:
                    case ConnectionState.waiting:

                      return const Center(child: CircularProgressIndicator());

                    default:
                      
                      List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                      return ListView.builder(

                        itemCount: documents.length,

                        itemBuilder: (context, index) {

                          return BoxMessage(

                            documents: documents[index],

                            my: documents[index].get(uid) == _user.uid,

                          );
                        },
                      );
                  }
                },
              ),
            ),
            _isLoading == true ? const LinearProgressIndicator() : Container(),
            TextComposer(getTextMSG: getTextMSG),
          ],
        ),
      ),
    );
  }

  void getTextMSG(String text, File? file) async {

    if(_user.ativate == false) await _user.getUser();

    if (_user.ativate == false) {

      scaffoldMessengerKey.currentState!.showSnackBar(

        const SnackBar(

          content: Text(
            "Não foi possível realizar login. Tente novamente!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Map<String, String> data = {
      uid : _user.uid!,
      senderName : _user.nameUser ?? 'Anonimato',
      senderPhotoUrl : _user.photoUrl ?? '',
      'time' : '${Timestamp.now()}', 
    };

    if (file != null) {

      setState(() {
        _isLoading = true;
      });

      Reference refer = FirebaseStorage.instance.ref();

      var listData = await refer.listAll();
      var idTam = listData.items.length;

      UploadTask task = FirebaseStorage.instance.ref().child('$idTam').putFile(file);

      TaskSnapshot taskSnapshot = await task.whenComplete(() => null);  

      String url = await taskSnapshot.ref.getDownloadURL();

      data[imgUrl] = url;

      setState(() {
        _isLoading = false;
      });

    }

    try {
      var tst = data[imgUrl];

      if (tst == null) {
        throw Exception();
      }

    } catch (e) {

      data['text'] = text;

    }

    FirebaseFirestore.instance.collection('messages').add(data);
  }
}
