import 'package:flutter/material.dart';

const title = 'IMC Calculator';
const color1 = Color.fromRGBO(25, 252, 0, 1);

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  AppBarDesign({super.key, required this.fncRestart});

  final Function() fncRestart;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color1,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        IconButton(
          onPressed: fncRestart,
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
