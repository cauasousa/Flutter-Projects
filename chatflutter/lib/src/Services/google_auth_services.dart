import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  
  // ignore: unused_element
  static Future<User?> connectUser() async {

    try {

      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);

      User? user = userCredential.user;

      return user;

    } catch (e) {

      // ignore: avoid_print
      print("ERROR GOOGLE ACESS $e");
      return null;

    }
    
  }

  // ignore: unused_element
  static disconnecteUser() async {

    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();

  }

}