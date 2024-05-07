import 'package:chatflutter/src/Views/chatpage/chat_screen.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      title: 'Chat Flutter',
      home: const ChatScreen(),
      
    );
  }
}
