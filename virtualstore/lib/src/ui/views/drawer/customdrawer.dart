import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/drawer/widget/widgetPositionded.dart';
import 'package:virtualstore/src/ui/views/drawer/widget/widgetTile.dart';
import 'package:virtualstore/src/ui/views/drawer/widget/widget_text_cadastrar.dart';
import 'package:virtualstore/src/ui/views/login/login_screen.dart';

class WidgetCustomDrawer extends StatefulWidget {
  WidgetCustomDrawer({super.key, required this.controller, required this.id});

  final PageController controller;
  final int id;

  @override
  State<WidgetCustomDrawer> createState() => _WidgetCustomDrawerState();
}

class _WidgetCustomDrawerState extends State<WidgetCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildBodyBack(),
          ListView(
            padding: EdgeInsets.only(left: 20.0, top: 12.0),
            children: [
              Container(
                height: 160,
                child: Stack(
                  children: [
                    WidgetPositionded(
                      text: "Flutter's\nClothing",
                      tam: 39,
                      top: 0.8,
                      cor: Color.fromARGB(255, 237, 229, 227),
                    ),
                    ScopedModelDescendant<Users>(
                      builder: (
                        BuildContext context,
                        Widget? child,
                        Users model,
                      ) =>
                          WidgetPositionded(
                        text: "Olá, ${model.isConnect() ? model.dataUser['name'] : ''}",
                        btt: 20.0,
                        lf: 0.0,
                        cor: Colors.white,
                      ),
                    ),
                    WidgetTextCadastrar(cadastrar: login_or_cadastrar),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
              WidgetDrawerTile(
                  icon: Icons.home,
                  text: 'Início',
                  controller: widget.controller,
                  id: 0),
              WidgetDrawerTile(
                  icon: Icons.list,
                  text: 'Produtos',
                  controller: widget.controller,
                  id: 1),
              WidgetDrawerTile(
                  icon: Icons.location_on,
                  text: 'Lojas',
                  controller: widget.controller,
                  id: 2),
              WidgetDrawerTile(
                  icon: Icons.playlist_add_check,
                  text: 'Meus Pedidos',
                  controller: widget.controller,
                  id: 3),
            ],
          )
        ],
      ),
    );
  }

  _buildBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color(0xFF023535),
            // Color(0xFF0FC2C0),
            Color(0xFF000B0D),
            Color(0xFF154B52),
          ],
        ),
      ),
    );
  }

  login_or_cadastrar(BuildContext context, Users model) {
    if (!model.isConnect()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    } else {

      model.signOut();
    }
  }
}
