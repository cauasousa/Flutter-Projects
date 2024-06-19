

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/card_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/mypages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Users>(
      model: Users(),
      child: ScopedModelDescendant<Users>(
        builder: (context, child, model) => ScopedModel<CardModel>(
          model: CardModel(users: model),
          child: MaterialApp(
            title: 'Virtual Store',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color(0xFF047D8D),
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
            ),
            home: MyPages(),
          ),
        ),
      ),
    );
  }
}

// Navigator.pushNamed(context, '/profile');
// Navigator.pushNamed(context, '/profile', arguments: userData); // passando dados
// final userData = ModalRoute.of(context).settings.arguments; // lendo dados passados














// adicionar no gitignore \\nao usei em 2024
// android/app/google-services.json
// ios/firebase_app_id_file.json
// ios/Runner/GoogleServices-Info.plist
// lib/firebase_options.dart


// comando que utilizei em 2024
// video base-> https://www.youtube.com/watch?v=k7RxHpOLIYQ&ab_channel=TheCoderBrain
// npm install -g firebase-tools 
// firebase login
// dart pub global activate flutterfire_cli
// coloquei no path-> C:\Users\CauaS\AppData\Local\Pub\Cache\bin
// flutterfire configure



// no site do firebase pra descobrir o SHI1 para googlePlay
// keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android



// codigin

// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// FirebaseFirestore.instance.collection('dados').doc('msg1').set({
//   'Bairros': "Chapada1",
//   "Complemento": "Perto da Igreja1",
//   "Nome": "China",
//   "rua": "Rua do mangueirão",
//   "cep": "685477"
// });