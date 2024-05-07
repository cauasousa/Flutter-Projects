// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatflutter/src/Services/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {

  User? _user;
  String? nameUser;
  String? photoUrl;
  String? uid;
  bool ativate = false;

  static final Users _instance = Users.internal();
  factory Users() => _instance;
  Users.internal();


  set user (User? value) {
    _user = value;
    _format();
  }

  // ignore: unused_element
  Future getUser() async {
    
    if (_user != null) return _user;

    _user = await GoogleAuthServices.connectUser();

    if (_user == null) return;

    _format();

  }

  // ignore: unused_element
  Future outUser() async {

    await GoogleAuthServices.disconnecteUser();

    _user = null;

    _format();

  }

  _format(){

    if (_user == null){
      uid = null;
      nameUser = null;
      photoUrl = null;
      ativate = false;

    }else{
      uid = _user?.uid;
      nameUser = _user!.displayName;
      photoUrl = _user!.photoURL;
      ativate = true;

    }

  }

}
