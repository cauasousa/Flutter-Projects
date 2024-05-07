import 'package:chatflutter/src/Services/google_auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Custom_Drawer extends StatelessWidget {
  Custom_Drawer({super.key, this.name});

  String? name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Stack(
        
        children: [
          ListView(
            children: [
              Container(
                height: 160,
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                padding: EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flutter\nConversation",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              height: 1.1,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          Text(
                            name == null ? "Olá, " : 'Olá, $name',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          name == null ? GestureDetector(
                            
                            child: Text(
                              "Entre ou cadastre-se > ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(147, 3, 168, 244),
                              ),
                            ),
                            onTap: () {
                              GoogleAuthServices.connectUser();
                            },
                          )
                          :GestureDetector(
                            
                            child: Text(
                              "Sair",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(147, 3, 168, 244),
                              ),
                            ),
                            onTap: () {
                              GoogleAuthServices.disconnecteUser();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                    Navigator.pop(context);
                  },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  padding: EdgeInsets.all(8.0),
                  
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_rounded,
                        color: Colors.black,
                        size: 38,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 14.0)),
                      Text(
                        "Chat",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          // color: const Color.fromARGB(147, 3, 168, 244),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {
                    
                },
                child:Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                padding: EdgeInsets.all(8.0), 
                  child: Row(
                    children: [
                      Icon(
                        Icons.miscellaneous_services_outlined,
                        size: 38,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 14.0)),
                      Text(
                        "Configuration",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          // color: const Color.fromARGB(147, 3, 168, 244),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                    
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline_outlined,
                        color: Colors.black,
                        size: 38,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 14.0)),
                      Text(
                        "Ajuda e feedback",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          // color: const Color.fromARGB(147, 3, 168, 244),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
