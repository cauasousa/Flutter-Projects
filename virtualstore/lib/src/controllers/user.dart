import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';

class Users extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  Map<String, dynamic> dataUser = Map();

  bool isloading = false;

  static Users of(BuildContext context) => ScopedModel.of<Users>(context);

  @override
  void addListener(VoidCallback listener) async {
    super.addListener(listener);

    await _loadCurrentUser();
  }

  signUp({
    required Map<String, dynamic> userData,
    required String pass,
    required Function() onSucess,
    required VoidCallback onFail,
  }) async {
    isloading = true;
    notifyListeners();

    await _auth
        .createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass,
    )
        .then((value) async {
      this.user = value.user;

      await _saveUserData(userData);

      await onSucess();
    }).onError((error, stackTrace) {
      onFail();
    });

    isloading = false;
    notifyListeners();
  }

  signIn({
    required String email,
    required String password,
    required Function() onSucess,
    required VoidCallback onFail,
  }) async {
    isloading = true;
    notifyListeners();

    if (user == null) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        user = value.user;
        await _loadCurrentUser();

        onSucess();
      }).onError((error, stackTrace) {
        onFail();
      });
    }

    isloading = false;
    notifyListeners();
  }

  recoverPass({required String email, required VoidCallback onSucess, required VoidCallback onFail}) async {

    await _auth.sendPasswordResetEmail(email: email).then((value) {
      onSucess();
    }).onError((error, stackTrace) {
      onFail();
    });

    notifyListeners();
  }

  _saveUserData(Map<String, dynamic> userData) async {
    this.dataUser = userData;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .set(userData)
        .onError((error, stackTrace) {
      print("ERRRO $error");
    });
  }

  signOut() async {
    await _auth.signOut();

    dataUser = Map();

    user = null;

    notifyListeners();
  }

  bool isConnect() {
    if (user == null) {
      return false;
    }

    return true;
  }

  _loadCurrentUser() async {
    if (user == null) {
      user = await _auth.currentUser!;
    }

    if (user != null) {
      if (dataUser['name'] == null) {
        var data = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get();
        dataUser = data.data() ?? Map();
      }
    }

    notifyListeners();
  }
}
