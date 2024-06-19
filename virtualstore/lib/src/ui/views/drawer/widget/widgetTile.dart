import 'package:flutter/material.dart';

class WidgetDrawerTile extends StatelessWidget {
  const WidgetDrawerTile({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
    required this.id,
  });

  final PageController controller;
  final int id;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Color.fromARGB(29, 255, 255, 255),
          onTap: () {
            
            if(id != 3){
              Navigator.pop(context);
            }

            controller.jumpToPage(id);
          },
          child: Container(
            height: 60,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: controller.page?.round() != id
                      ? Colors.white
                      : Color(0xFF16FDF9),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 15.0)),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: controller.page?.round() != id
                        ? Colors.white
                        : Color(0xFF16FDF9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
